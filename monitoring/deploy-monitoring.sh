#!/bin/bash
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus --namespace monitoring -f values-prometheus.yaml

helm install grafana grafana/grafana --namespace monitoring -f values-grafana.yaml

kubectl get svc -n monitoring
#!/bin/bash

# Ensure monitoring namespace exists
echo "Creating 'monitoring' namespace if it does not exist..."
kubectl get namespace monitoring >/dev/null 2>&1 || kubectl create namespace monitoring

# Add Helm repos
echo "Adding Prometheus and Grafana Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Add Loki Helm repo
echo "Adding Loki Helm repository..."
helm repo add grafana https://grafana.github.io/helm-charts || true
helm repo update

# Install Prometheus
echo "Installing Prometheus..."
helm upgrade --install prometheus prometheus-community/prometheus \
	--namespace monitoring \
	--values monitoring/values-prometheus.yaml

# Install Grafana
echo "Installing Grafana..."
helm upgrade --install grafana grafana/grafana \
	--namespace monitoring \
	--values monitoring/values-grafana.yaml

# Install Loki
echo "Installing Loki..."
helm upgrade --install loki grafana/loki \
	--namespace monitoring \
	--values monitoring/values-loki.yaml

# Show resulting services
echo "\nServices in 'monitoring' namespace:"
kubectl get svc -n monitoring

echo "\nIf you are on Windows, run each command manually or use Git Bash/WSL for this script."