#!/bin/bash

# Verifica si AWS CLI y kubectl están instalados
if ! [ -x "$(command -v aws)" ]; then
  echo "Error: AWS CLI no está instalado." >&2
  exit 1
fi

if ! [ -x "$(command -v kubectl)" ]; then
  echo "Error: kubectl no está instalado." >&2
  exit 1
fi

# Configuración del EKS Cluster
REGION="us-east-1"        # Cambia por tu región preferida
CLUSTER_NAME="my-eks-cluster"
NODE_GROUP_NAME="eks-node-group"
NODE_TYPE="t3.medium"     # Tipo de instancia de los nodos
NODE_COUNT=2              # Número de nodos

# Crea el clúster EKS
echo "Creando el clúster EKS: $CLUSTER_NAME en la región $REGION..."
aws eks create-cluster --name $CLUSTER_NAME --region $REGION \
  --kubernetes-version "1.27" \
  --role-arn <ARN_DEL_ROL_DE_EKS> \
  --resources-vpc-config subnetIds=<SUBNET_IDS>,securityGroupIds=<SECURITY_GROUP_ID>

echo "Esperando que el clúster EKS esté activo..."
aws eks wait cluster-active --name $CLUSTER_NAME --region $REGION
echo "El clúster EKS está activo."

# Configura kubectl para interactuar con el clúster
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

# Crea un grupo de nodos
echo "Creando el grupo de nodos: $NODE_GROUP_NAME..."
aws eks create-nodegroup --cluster-name $CLUSTER_NAME --nodegroup-name $NODE_GROUP_NAME \
  --region $REGION --node-role <ARN_DEL_ROL_DE_NODOS> \
  --subnets <SUBNET_IDS> --instance-types $NODE_TYPE --scaling-config minSize=1,maxSize=3,desiredSize=$NODE_COUNT

echo "Esperando que el grupo de nodos esté activo..."
aws eks wait nodegroup-active --cluster-name $CLUSTER_NAME --nodegroup-name $NODE_GROUP_NAME --region $REGION
echo "El grupo de nodos está activo."

# Integra EKS con Rancher
echo "Integrando el clúster EKS con Rancher..."
kubectl config use-context arn:aws:eks:$REGION:<ACCOUNT_ID>:cluster/$CLUSTER_NAME

RANCHER_SERVER="https://localhost:8443" # URL del servidor Rancher
RANCHER_TOKEN="<RANCHER_API_TOKEN>"    # Genera un token en Rancher para la API

# Añade el clúster a Rancher
curl -k -X POST -H "Authorization: Bearer $RANCHER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
        "type": "cluster",
        "name": "'"$CLUSTER_NAME"'",
        "importYaml": "'"$(kubectl config view --raw)"'"
      }' \
  $RANCHER_SERVER/v3/clusters

echo "El clúster EKS se ha integrado correctamente en Rancher."
echo "¡Proceso completo!"
