# 🚀 Kubernetes Microservices Deployment Platform on AWS EKS

A production-grade microservices architecture deployed on **Amazon EKS (Elastic Kubernetes Service)** using **Docker**, **Terraform**, and **Python (Flask)**.  
Each microservice (Auth, Orders, Payments) runs in its own container and is automatically deployed, scaled, and exposed through AWS Load Balancer.

---

## 🧰 Tech Stack

- **AWS EKS** – Managed Kubernetes cluster  
- **AWS ECR** – Private Docker image registry  
- **Terraform** – Infrastructure as Code (IaC)  
- **Docker** – Containerized microservices  
- **Kubernetes** – Service orchestration & scaling  
- **Python (Flask)** – Lightweight microservices framework  
- **CloudWatch** – Monitoring and logging  
- **Horizontal Pod Autoscaler (HPA)** – Auto-scaling based on CPU utilization  

---

## ✨ Key Features

- Modular **microservices** (Auth, Orders, Payments)  
- **EKS-based orchestration** with automated deployments  
- **LoadBalancer Services** for public endpoints  
- **Horizontal Pod Autoscaling (HPA)** for scaling under load  
- **Terraform-based AWS provisioning**  
- **ECR integration** for secure image management  
- Lightweight Flask APIs for demonstration  

---

## ⚙️ How to Use

### 1️⃣ Clone the Repository
git clone https://github.com/<your-username>/

k8s-microservices-eks.git

cd k8s-microservices-eks

 ### 2️⃣ Configure AWS CLI

Make sure your AWS credentials are configured properly:

aws configure

### 3️⃣ Build and Push Docker Images

Replace <AWS_ACCOUNT_ID> and <AWS_REGION> with your values.

# Auth Service
docker build -t auth-service:latest ./services/auth

docker tag auth-service:latest <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/auth-service:latest

docker push <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/auth-service:latest

# Orders Service
docker build -t orders-service:latest ./services/orders

docker tag orders-service:latest <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/orders-service:latest

docker push <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/orders-service:latest

# Payments Service
docker build -t payments-service:latest ./services/payments

docker tag payments-service:latest <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/payments-service:latest

docker push <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/payments-service:latest

### 4️⃣ Deploy Infrastructure with Terraform

Provision your EKS cluster and supporting AWS resources.

cd terraform

terraform init

terraform apply -auto-approve


Once complete, configure your kubeconfig:

aws eks update-kubeconfig --name <cluster-name> --region <AWS_REGION>

### 5️⃣ Deploy to Kubernetes

Apply all Kubernetes manifests:

kubectl apply -f k8s/base/


Verify deployments:

kubectl get pods -n microservices

kubectl get svc -n microservices

### 6️⃣ Access Services

Each service (Auth, Orders, Payments) will have its own LoadBalancer URL.

You can get them using:

kubectl get svc -n microservices


Example endpoints:

Auth:     http://<auth-lb-url>/login
Orders:   http://<orders-lb-url>/order
Payments: http://<payments-lb-url>/pay

### 🧠 Learnings & Concepts Covered

Real-world Kubernetes microservices architecture

AWS EKS cluster setup with Terraform

Containerization and ECR registry integration

Horizontal Pod Autoscaling (HPA) configuration

Multi-service networking and load balancing

CloudWatch integration for metrics and logs

### 🧹 Cleanup

To avoid charges, destroy AWS resources:

cd terraform

terraform destroy -auto-approve

### 🏗 Future Enhancements

Add Ingress + ALB Controller for unified routing (/auth, /orders, /payments)

Implement CI/CD pipeline using GitHub Actions or Jenkins

Introduce centralized logging with OpenSearch or Prometheus + Grafana

Deploy service mesh (Istio) for traffic management and observability