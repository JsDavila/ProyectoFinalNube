#!/bin/bash

# Instala K3D
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Crea un clúster con 2 nodos de alta disponibilidad
k3d cluster create mycluster \
  --servers 2 \
  --agents 2 \
  -p "8081:80@loadbalancer" -p "6443:443@loadbalancer"

echo "Clúster K3D creado. Acceso: http://localhost:8081"

# Crea un namespace para la aplicación
kubectl create namespace myapp

# Despliega una aplicación escalable y de alta disponibilidad (nginx como ejemplo)
kubectl create deployment nginx --image=nginx --replicas=4 -n myapp
kubectl expose deployment nginx --type=LoadBalancer --port=80 --target-port=80 -n myapp

echo "Aplicación NGINX desplegada. Acceso: http://localhost:8081"
