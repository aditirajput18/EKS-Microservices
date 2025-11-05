#!/bin/bash
set -e

# -----------------------------
# Configuration
# -----------------------------
K8S_DIR="./k8s"
SERVICES=("user" "product" "order")

# Apply ConfigMap and Deployments
echo "⚙️ Applying ConfigMaps..."
kubectl apply -f $K8S_DIR/configmap.yaml

# Deploy services and deployments
for SERVICE in "${SERVICES[@]}"; do
  echo "🚀 Deploying $SERVICE microservice..."
  kubectl apply -f $K8S_DIR/${SERVICE}-deployment.yaml
  kubectl apply -f $K8S_DIR/${SERVICE}-service.yaml
done

# Apply ingress (optional)
if [ -f "$K8S_DIR/ingress.yaml" ]; then
  echo "🌐 Applying Ingress..."
  kubectl apply -f $K8S_DIR/ingress.yaml
fi

echo "✅ Kubernetes deployment complete!"
kubectl get pods
kubectl get svc
