# Kubernetes Monitoring Stack

This folder provides a ready-to-use monitoring stack for Kubernetes using **Prometheus**, **Grafana**, and **Loki**. Il permet la collecte de métriques, la visualisation, l’alerte et la centralisation des logs (avec détection d’anomalies possible via Loki).

## What is included?
- **Prometheus**: Metrics collection and alerting system.
- **Grafana**: Visualization and dashboarding for Prometheus and Loki data.
- **Loki**: Centralized log aggregation, query, and anomaly detection (logs).

## How to Deploy

1. Ensure you have [kubectl](https://kubernetes.io/docs/tasks/tools/) and [Helm](https://helm.sh/docs/intro/install/) installed and configured for your cluster.
2. Run the deployment script:

	```sh
	bash monitoring/deploy-monitoring.sh
	```
	> **Note:** On Windows, run each command in the script manually or use Git Bash/WSL.

This script will deploy Prometheus, Grafana, **and Loki** for logs.

## Accessing Dashboards

- **Prometheus**:
	- Run: `kubectl get svc -n monitoring`
	- Find the `prometheus-server` service (NodePort: **30900**)
	- Access: `http://<NodeIP>:30900`

- **Grafana**:
	- Run: `kubectl get svc -n monitoring`
	- Find the `grafana` service (NodePort: **30950**)
	- Access: `http://<NodeIP>:30950`

- **Loki** (API/logs):
	- Run: `kubectl get svc -n monitoring`
	- Find the `loki` service (NodePort: **30960**)
	- Access: `http://<NodeIP>:30960` (API)

> **Grafana** centralizes both metrics (Prometheus) and logs (Loki). Ajoutez Loki comme source de données dans Grafana (menu "Configuration > Data Sources > Add data source > Loki").

## Grafana Credentials
- **Username:** admin
- **Password:** admin (change in `values-grafana.yaml` for security)

## Uninstalling

To remove the monitoring stack:

```sh
helm uninstall prometheus -n monitoring
helm uninstall grafana -n monitoring
helm uninstall loki -n monitoring
kubectl delete namespace monitoring
```