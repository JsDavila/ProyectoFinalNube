#!/bin/bash

# Añade los repositorios de Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Añade repositorios de Grafana y Prometheus
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Instala Prometheus en el clúster
kubectl create namespace monitoring
helm install prometheus prometheus-community/prometheus --namespace monitoring

# Instala Grafana en el clúster
helm install grafana grafana/grafana --namespace monitoring --set adminPassword=admin

# Obtén la dirección IP del servicio Grafana
echo "Espera unos momentos mientras los servicios se inicializan..."
kubectl get svc -n monitoring grafana -o jsonpath="{.status.loadBalancer.ingress[*].ip}"

echo "Grafana instalado. Accede con usuario 'admin' y contraseña 'admin'."
echo "Prometheus y Grafana desplegados en el namespace 'monitoring'."
