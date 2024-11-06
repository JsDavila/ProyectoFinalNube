
# **Proyecto Final: Computación en la Nube**

**Autores**:  
- Sebastián Dávila - 2181675  
- Karim Andrés Perea - 2167415  

---

## **Descripción del Proyecto**

Este proyecto tiene como objetivo implementar un entorno de orquestación y gestión de contenedores utilizando **Rancher**, **Amazon EKS** y herramientas de monitorización como **Prometheus** y **Grafana**. 

Con este proyecto, se busca:
- Automatizar la creación y gestión de clústeres Kubernetes.
- Desplegar aplicaciones altamente disponibles.
- Monitorizar el rendimiento y la salud de los clústeres con herramientas avanzadas.
- Facilitar la integración de Rancher para la gestión centralizada de clústeres en la nube y en entornos locales.

---

## **Tecnologías Utilizadas**

### **1. Rancher**
Rancher es una plataforma de gestión de Kubernetes que simplifica el despliegue, la monitorización y la administración de clústeres.

**Características principales:**
- Gestión multi-clúster.
- Integración con proveedores de nube (Amazon EKS, Azure AKS, Google GKE).
- Seguridad y control de acceso basados en roles.

---

### **2. Kubernetes (K3D y Amazon EKS)**
- **K3D**: Para entornos de desarrollo locales.
- **Amazon EKS**: Para clústeres en la nube gestionados por AWS.

**Ventajas:**
- Escalabilidad automática de aplicaciones.
- Implementación de patrones como alta disponibilidad y balanceo de carga.
- Compatibilidad con herramientas de monitoreo y despliegue continuo.

---

### **3. Prometheus y Grafana**
- **Prometheus**: Recolecta métricas desde clústeres Kubernetes.
- **Grafana**: Proporciona dashboards gráficos para visualizar datos de Prometheus.

**Casos de uso:**
- Monitoreo de recursos como CPU, memoria y tráfico de red.
- Alertas en tiempo real para prevenir problemas de rendimiento.
- Visualización de datos históricos para análisis y optimización.

---

## **Requisitos del Proyecto**

1. **Sistema Operativo:**
   - Linux (Ubuntu, Debian o Kali).
   - WSL2 en Windows con soporte para Docker.

2. **Herramientas necesarias:**
   - Docker (`>= 20.10`)
   - AWS CLI (`>= 2.x`)
   - kubectl (`>= 1.27`)
   - Helm (`>= 3.x`)
   - curl
   - Acceso a una cuenta de AWS con permisos para gestionar EKS.

3. **Recursos mínimos:**
   - 4 CPUs.
   - 8 GB de RAM.
   - 50 GB de almacenamiento.

---

## **Paso a Paso de Instalación**

### **1. Configuración Inicial**
1. Actualiza el sistema:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. Instala Docker:
   ```bash
   sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
   curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
   sudo systemctl enable docker
   ```

---

### **2. Instalación de Rancher**
1. Guarda y ejecuta el script `install_rancher.sh`:
   ```bash
   chmod +x install_rancher.sh
   ./install_rancher.sh
   ```
2. Accede a Rancher: [https://localhost:8443](https://localhost:8443)

---

### **3. Configuración de K3D**
1. Guarda y ejecuta el script `install_k3d.sh`:
   ```bash
   chmod +x install_k3d.sh
   ./install_k3d.sh
   ```
2. Verifica la aplicación en `http://localhost:8081`.

---

### **4. Instalación de Amazon EKS**
1. Configura el clúster EKS e integra con Rancher:
   ```bash
   chmod +x configure_eks_rancher.sh
   ./configure_eks_rancher.sh
   ```
2. El clúster EKS aparecerá en Rancher para su gestión.

---

### **5. Instalación de Grafana y Prometheus**
1. Guarda y ejecuta el script `install_monitoring.sh`:
   ```bash
   chmod +x install_monitoring.sh
   ./install_monitoring.sh
   ```
2. Accede a Grafana:  
   - URL: `http://<node_ip>:3000`  
   - Usuario: `admin`  
   - Contraseña: `admin`

---

## **Uso en un Entorno Laboral**
1. Gestión multi-clúster con Rancher.
2. Despliegue de aplicaciones escalables.
3. Monitorización con Grafana y Prometheus.
4. Integración continua con herramientas como Jenkins y GitLab CI.


---

## **Referencias**
- [Documentación Oficial de Rancher](https://rancher.com/docs/)
- [Documentación Oficial de Kubernetes](https://kubernetes.io/docs/)
- [Documentación de Prometheus](https://prometheus.io/docs/)
- [Documentación de Grafana](https://grafana.com/docs/)

---

¡Gracias por explorar nuestro proyecto!  😊
