#!/bin/bash

set -e

echo "================================================"
echo "🚀 ARGO CD INSTALLATION FOR AWS EKS"
echo "================================================"
echo ""

# Check AWS CLI
echo "🔍 Checking AWS CLI..."

if command -v aws >/dev/null 2>&1; then
    echo "✅ AWS CLI is installed"
    aws --version
else
    echo "❌ AWS CLI is not installed"
    exit 1
fi

echo ""

# Check kubectl
echo "🔍 Checking kubectl..."

if command -v kubectl >/dev/null 2>&1; then
    echo "✅ kubectl is installed"
else
    echo "❌ kubectl is not installed"
    exit 1
fi

echo ""

# Check EKS connection
echo "☸️ Checking connection to EKS..."

if kubectl get nodes >/dev/null 2>&1; then
    echo "✅ Connected to EKS"
else
    echo "❌ Cannot connect to your EKS cluster"
    exit 1
fi

echo ""

# Show EKS nodes
echo "🖥️ EKS Worker Nodes"
kubectl get nodes

echo ""

# Create Argo CD namespace
echo "📁 Creating Argo CD namespace..."

kubectl create namespace argocd \
    --dry-run=client \
    -o yaml | kubectl apply -f -

echo "✅ Argo CD namespace ready"

echo ""

# Install Argo CD
echo "📦 Installing Argo CD into EKS..."

kubectl apply \
    -n argocd \
    --server-side \
    --force-conflicts \
    -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo ""
echo "✅ Argo CD Kubernetes resources installed"
echo ""

# Install Argo CD CLI
echo "🛠️ Installing Argo CD CLI..."

ARGOCD_VERSION=$(curl -s \
    https://api.github.com/repos/argoproj/argo-cd/releases/latest \
    | grep '"tag_name"' \
    | cut -d '"' -f 4)

curl -sSL -o /tmp/argocd-linux-amd64 \
    "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64"

sudo install -m 555 \
    /tmp/argocd-linux-amd64 \
    /usr/local/bin/argocd

rm -f /tmp/argocd-linux-amd64

echo "✅ Argo CD CLI installed"

echo ""

# Wait for Argo CD server
echo "⏳ Waiting for Argo CD server to become ready..."

kubectl wait \
    --for=condition=Available \
    deployment/argocd-server \
    -n argocd \
    --timeout=300s

echo ""
echo "📦 Checking Argo CD pods..."
echo ""

kubectl get pods -n argocd

echo ""

# Get initial admin password
echo "🔐 Getting Argo CD admin password..."

ARGO_PASSWORD=$(kubectl -n argocd \
    get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d)

echo ""

# Stop old Argo CD port-forward if one exists
echo "🔄 Checking port 8081..."

pkill -f "kubectl port-forward.*argocd-server.*8081:443" \
    2>/dev/null || true

# Start port-forward automatically
echo "🌐 Starting Argo CD on port 8081..."

nohup kubectl port-forward \
    --address 0.0.0.0 \
    svc/argocd-server \
    -n argocd \
    8081:443 \
    > /tmp/argocd-port-forward.log 2>&1 &

sleep 5

# Check port 8081
if ss -lnt | grep -q ':8081'; then
    echo "✅ Argo CD port 8081 is running"
else
    echo "❌ Argo CD port-forward failed"
    echo ""
    echo "Check the error with:"
    echo "cat /tmp/argocd-port-forward.log"
    exit 1
fi

echo ""
echo "================================================"
echo "🎉 ARGO CD INSTALLATION COMPLETE 🎉"
echo "================================================"
echo ""
echo "☁️  AWS EKS          ✅ READY"
echo "☸️  Kubernetes       ✅ READY"
echo "🐙 Argo CD           ✅ READY"
echo "🌐 Port 8081         ✅ READY"
echo ""
echo "👤 Username: admin"
echo "🔑 Password: $ARGO_PASSWORD"
echo ""
echo "🌐 Open Argo CD:"
echo "https://YOUR-EC2-PUBLIC-IP:8081"
echo ""
echo "🚀 Argo CD is ready for GitOps!"
echo "================================================"
