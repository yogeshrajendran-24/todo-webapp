# 🚀 Todo Web App – End-to-End DevOps CI/CD Pipeline

This project demonstrates a complete DevOps pipeline for deploying a simple Todo web application using modern tools and cloud infrastructure.
It covers CI/CD automation, containerization, Kubernetes orchestration, and secure deployment on AWS.

# 📌 Tech Stack
- Frontend: HTML, CSS, JavaScript
- CI/CD: Jenkins
- Containerization: Docker
- Orchestration: Kubernetes (K8s)
- Cloud: AWS EC2
- Ingress & TLS: NGINX Ingress + Cert-Manager (Let's Encrypt)
- Version Control: GitHub
- Registry: Docker Hub

# 🏗️ Architecture
```
Developer (GitHub Push)
        │
        ▼
   Jenkins Pipeline
        │
        ├── Checkout Code
        ├── Build Docker Image
        ├── Push to Docker Hub
        └── Deploy to Kubernetes
                │
                ▼
        Kubernetes Cluster (AWS EC2)
                │
        ├── Deployment (Pods)
        ├── Service (ClusterIP)
        └── Ingress Controller
                │
                ▼
            Domain + TLS 
                │
                ▼
        🌐 User Access (Browser)

```
# 🔄 CI/CD Pipeline Flow
- Code is pushed to GitHub repository
- Jenkins pipeline is triggered automatically
- Jenkins performs:
  - Code checkout
  - Docker image build
  - Push image to Docker Hub
  - Deploy to Kubernetes cluster
- Kubernetes:
  - Pulls latest image
  - Updates running pods
- Application is exposed via:
  - Ingress Controller
  - HTTPS using Let's Encrypt TLS
 
```
📂 Project Structure
.
├── img/                
├── k8s/               
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── certificate.yaml
├── Dockerfile         
├── Jenkinsfile        
├── index.html        
├── script.js         
├── style.css         
└── kubeconfig        
```

# ⚙️ Jenkins Pipeline Stages
  ✅ Checkout SCM
  ✅ Checkout Code
  ✅ Build Docker Image
  ✅ Push Image to Docker Hub
  ✅ Deploy to Kubernetes
  ✅ Post Actions

# ☸️ Kubernetes Components
- Deployment → Manages application pods
- Service → Internal communication
- Ingress → External routing
- Cert-Manager → Automatic TLS certificates

# 🐳 Docker
- Application is containerized using a Dockerfile
- Images are pushed to Docker Hub
- Versioned using tags from Jenkins builds

# ☁️ AWS Deployment
- Hosted on EC2 instance
- Kubernetes cluster runs on the instance
- Public IP + domain used for access

# 🌐 Live Application

👉 https://www.todo-webapp.online
 (or your configured domain)

# 🚀 How to Run Locally
# Clone repository
git clone https://github.com/your-username/todo-webapp.git

# Build Docker image
docker build -t todo-app .

# Run container
- docker run -d -p 8080:80 todo-app

📈 Key Highlights
- Fully automated CI/CD pipeline
- Real-world DevOps workflow
- Kubernetes production-style deployment
- HTTPS enabled with zero manual cert handling
- Cloud-native architecture
