#!/bin/bash

echo "========================================"
echo "  🔍 Diagnostic Stack Monitoring"
echo "========================================"
echo ""

echo "1️⃣ État des pods :"
kubectl get pods -n monitoring
echo ""

echo "2️⃣ État des services :"
kubectl get svc -n monitoring
echo ""

echo "3️⃣ État des PVC (si activés) :"
kubectl get pvc -n monitoring
echo ""

echo "4️⃣ Événements récents :"
kubectl get events -n monitoring --sort-by='.lastTimestamp' | tail -20
echo ""

echo "5️⃣ Logs Loki (dernières 50 lignes) :"
kubectl logs -n monitoring -l app.kubernetes.io/name=loki --tail=50
echo ""

echo "6️⃣ Logs Prometheus (dernières 50 lignes) :"
kubectl logs -n monitoring -l app=prometheus,component=server --tail=50
echo ""

echo "7️⃣ Logs Grafana (dernières 50 lignes) :"
kubectl logs -n monitoring -l app.kubernetes.io/name=grafana --tail=50
echo ""

echo "========================================"
echo "  Pour plus de détails sur un pod :"
echo "  kubectl describe pod <POD_NAME> -n monitoring"
echo "========================================"