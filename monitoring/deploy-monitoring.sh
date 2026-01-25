#!/bin/bash

set -e  # Arrêter en cas d'erreur

echo "========================================"
echo "  Déploiement Stack Monitoring K8s"
echo "  Prometheus + Grafana + Loki"
echo "========================================"
echo ""

# Vérifier que kubectl fonctionne
if ! kubectl cluster-info &>/dev/null; then
    echo "❌ ERREUR : kubectl ne peut pas se connecter au cluster"
    echo "Vérifiez votre configuration kubeconfig"
    exit 1
fi

echo "✅ Connexion au cluster OK"
echo ""

# Créer le namespace monitoring
echo "📦 Création du namespace 'monitoring'..."
kubectl get namespace monitoring &>/dev/null || kubectl create namespace monitoring
echo "✅ Namespace 'monitoring' prêt"
echo ""

# Ajouter les repos Helm (URLS CORRIGÉES)
echo "📚 Ajout des repositories Helm..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
echo "✅ Repositories Helm ajoutés et mis à jour"
echo ""

# Installer Prometheus
echo "🔧 Installation de Prometheus..."
helm upgrade --install prometheus prometheus-community/prometheus \
    --namespace monitoring \
    --values monitoring/values-prometheus.yaml \
    --wait \
    --timeout 5m
echo "✅ Prometheus installé"
echo ""

# Installer Grafana
echo "📊 Installation de Grafana..."
helm upgrade --install grafana grafana/grafana \
    --namespace monitoring \
    --values monitoring/values-grafana.yaml \
    --wait \
    --timeout 5m
echo "✅ Grafana installé"
echo ""

# Installer Loki
echo "📝 Installation de Loki..."
helm upgrade --install loki grafana/loki \
    --namespace monitoring \
    --values monitoring/values-loki.yaml \
    --wait \
    --timeout 5m
echo "✅ Loki installé"
echo ""

# Afficher l'état
echo "========================================"
echo "  📋 État du déploiement"
echo "========================================"
echo ""

echo "🔍 Services déployés :"
kubectl get svc -n monitoring
echo ""

echo "🔍 Pods en cours d'exécution :"
kubectl get pods -n monitoring
echo ""

# Récupérer l'IP du nœud
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
if [ -z "$NODE_IP" ]; then
    NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
fi

echo "========================================"
echo "  🎉 Déploiement terminé !"
echo "========================================"
echo ""
echo "📍 Accès aux dashboards :"
echo ""
echo "  🔹 Prometheus : http://${NODE_IP}:30900"
echo "  🔹 Grafana    : http://${NODE_IP}:30950"
echo "  🔹 Loki API   : http://${NODE_IP}:30960"
echo ""
echo "🔐 Credentials Grafana :"
echo "  👤 Username : admin"
echo "  🔑 Password : admin123"
echo ""
echo "💡 Conseil : Changez le mot de passe Grafana après la première connexion"
echo ""