# hello-platform

A local GitOps setup deploying a frontend and backend Hello World service using ArgoCD, Helm, Terraform and Terragrunt. Runs on kind (Kubernetes in Docker) with two environments — dev and staging.

## How it works

Terragrunt generates per-environment Helm values files for each service. Those get committed to this repo. ArgoCD watches the repo and keeps the cluster in sync automatically.

```
GitHub repo → ArgoCD → kind cluster
                         ├── dev namespace
                         │     ├── frontend  (nginx:alpine, port 80)
                         │     └── backend   (http-echo, port 5678)
                         └── staging namespace
                               ├── frontend  (2 replicas)
                               └── backend   (2 replicas)
```

The backend NetworkPolicy only allows ingress from frontend pods — nothing else can reach it directly.

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) — kind runs inside Docker
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Terraform >= 1.3](https://developer.hashicorp.com/terraform/install)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [ArgoCD CLI](https://argo-cd.readthedocs.io/en/stable/cli_installation/)

Make sure Docker Desktop is running before you do anything else.

## Setup

**1. Create the cluster**

```bash
kind create cluster --name hello-platform --config kind-config.yaml
```

**2. Install ArgoCD**

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# wait for it to come up
kubectl wait --for=condition=available deployment -l app.kubernetes.io/name=argocd-server -n argocd --timeout=120s

# get the admin password
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```

To open the UI:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
# https://localhost:8080  (user: admin)
```

**3. Generate Helm values**

The values files are already committed, but if you change anything in the Terragrunt configs re-run this:

```bash
cd envs/dev/frontend && terragrunt apply && cd ../../..
cd envs/dev/backend && terragrunt apply && cd ../../..
cd envs/staging/frontend && terragrunt apply && cd ../../..
cd envs/staging/backend && terragrunt apply && cd ../../..
```

Then commit and push the updated values files.

**4. Deploy via ArgoCD**

```bash
argocd login localhost:8080 --username admin --password <password> --insecure

kubectl apply -f argocd/dev-frontend.yaml
kubectl apply -f argocd/dev-backend.yaml
kubectl apply -f argocd/staging-frontend.yaml
kubectl apply -f argocd/staging-backend.yaml
```

ArgoCD will create the namespaces and sync everything automatically.

**5. Check it's working**

```bash
argocd app list
kubectl get pods -n dev
kubectl get pods -n staging
```

Open in browser (NodePort via kind port mappings):
```
http://localhost:8081   # dev frontend
http://localhost:8082   # dev backend
http://localhost:8083   # staging frontend
http://localhost:8084   # staging backend
```

## Project layout

```
├── modules/app/              # terraform module — outputs a helm values file
├── envs/
│   ├── dev/
│   │   ├── frontend/         # 1 replica, nginx:alpine
│   │   └── backend/          # 1 replica, http-echo, restricted ingress
│   └── staging/
│       ├── frontend/         # 2 replicas
│       └── backend/          # 2 replicas
├── charts/hello-app/         # single shared helm chart
│   └── templates/
├── argocd/                   # one Application manifest per service per env
└── .github/workflows/        # helm lint on PR
```

## Cleanup

```bash
kind delete cluster --name hello-platform
```
