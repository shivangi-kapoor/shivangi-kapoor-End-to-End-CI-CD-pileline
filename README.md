# End-to-End DevOps CI/CD Pipeline | AWS, Jenkins, Docker, Kubernetes, Prometheus & Grafana

An end-to-end DevOps project demonstrating automated application delivery, containerization, Kubernetes orchestration, and application observability using industry-standard DevOps tools.

## Project Overview

This project implements a CI/CD workflow for a Python Flask web application.

The solution integrates Jenkins running on AWS EC2 with Docker image creation, Docker Hub as the container registry, and Kubernetes deployment using a local kind cluster.

Application metrics are collected through Prometheus and visualized using Grafana dashboards.

### Technology Stack

| Category | Technology |
|---|---|
| Cloud Infrastructure | AWS EC2 |
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| CI/CD | Jenkins |
| Application | Python Flask |
| Version Control | Git and GitHub |
| Containerization | Docker |
| Container Registry | Docker Hub |
| Container Orchestration | Kubernetes (kind) |
| Metrics Collection | Prometheus |
| Visualization | Grafana |
| Development Environment | Ubuntu / WSL |

## Architecture

```text
                   Developer
                       |
                       v
                 GitHub Repository
                       |
                       v
                 Jenkins Pipeline
                 (AWS EC2 Server)
                       |
             Build and Package
                       |
                       v
                  Docker Image
                       |
                       v
                   Docker Hub
                       |
                       v
              Jenkins Deployment Agent
                   (Ubuntu / WSL)
                       |
                       v
               Kubernetes Cluster
                      (kind)
                       |
              +--------+--------+
              |                 |
         Flask Pod 1       Flask Pod 2
              |                 |
              +--------+--------+
                       |
                Flask Service
                       |
                /metrics endpoint
                       |
                       v
                   Prometheus
                       |
                       v
                     Grafana
                       |
               Monitoring Dashboard
```

## CI/CD Workflow

**1. Source Code Management**

Application code, Docker configuration, Kubernetes manifests, and monitoring configurations are maintained in GitHub.

**2. Continuous Integration**

Jenkins coordinates the CI/CD workflow, including building the container image.

**3. Docker Image Management**

The application is packaged into a Docker image and published to Docker Hub.

Docker image repository:

`shivix/flask-devops-app`

**4. Kubernetes Deployment**

The Jenkins deployment agent interacts with the local Kubernetes cluster using `kubectl`.

The application is deployed as a Kubernetes Deployment with two replicas and exposed internally using a Kubernetes Service.

**5. Application Monitoring**

The Flask application exposes Prometheus-compatible metrics through `/metrics`.

Prometheus discovers the application pods using Kubernetes annotations and scrapes metrics periodically.

Grafana queries Prometheus to display application health and HTTP metrics.

## Repository Structure

```text
.
├── ansible/
├── app/
├── jenkins/
├── k8s/
├── monitoring/
├── terraform/
├── requirements.txt
├── .gitignore
└── README.md
```

### Directory Responsibilities

- `ansible/` — Infrastructure and software configuration automation.
- `app/` — Flask application source and related files.
- `jenkins/` — CI/CD pipeline configuration.
- `k8s/` — Kubernetes deployment and service manifests.
- `monitoring/` — Prometheus and Grafana configuration.
- `terraform/` — Infrastructure as Code for AWS resources.
- `requirements.txt` — Python dependencies.

## Kubernetes Deployment

The application runs inside a local Kubernetes cluster created using kind.

Namespace: `flask-cicd`

Deployment: `flask-app`

Service: `flask-service`

Desired application replicas: 2

Useful commands:

```bash
kubectl get pods -n flask-cicd
kubectl get deployments -n flask-cicd
kubectl get services -n flask-cicd
kubectl rollout status deployment/flask-app -n flask-cicd
```

## Monitoring and Observability

### Prometheus

Prometheus is deployed inside the Kubernetes cluster using Helm.

The Flask application uses `prometheus_flask_exporter` to expose HTTP metrics.

Metrics endpoint:

`/metrics`

Prometheus uses Kubernetes pod discovery to scrape the application.

Example availability query:

```promql
up{job="kubernetes-pods",namespace="flask-cicd"}
```

A value of `1` indicates a successful scrape.

### Grafana

Grafana is deployed using Helm and connected to Prometheus as a data source.

The monitoring dashboard contains panels for:

- Application availability
- HTTP request rate
- HTTP 5xx error rate

Example request-rate query:

```promql
sum(rate(flask_http_request_total{namespace="flask-cicd"}[5m]))
```

Example server-error query:

```promql
sum(rate(flask_http_request_total{namespace="flask-cicd",status=~"5.."}[5m]))
```

Actual metric labels depend on the Flask exporter configuration.

## Validation

The implementation has been validated through:

- Successful Flask application deployment to Kubernetes.
- Running application replicas.
- Successful `/metrics` responses from the application.
- Successful Prometheus scraping of the Flask pods.
- Grafana access and dashboard creation.

A complete source-commit-to-deployment regression test is recommended whenever pipeline or infrastructure configuration changes.

## Troubleshooting and Lessons Learned

### Kubernetes Deployment Rollout Delays

**Challenge:** Kubernetes deployment rollouts experienced timeouts.

**Investigation:** Examined pod readiness, application health, and deployment status.

**Learning:** A rollout timeout does not always mean an application has permanently failed. Pod readiness and resource constraints must be checked before rebuilding or redeploying.

### Prometheus Target Discovery

**Challenge:** Application metrics were accessible, but the custom Prometheus scrape job did not produce an active target.

**Resolution:** Enabled Kubernetes pod annotations and used Prometheus's existing Kubernetes pod discovery job.

**Learning:** Prometheus service discovery and relabeling configuration directly affect whether metrics targets become active.

### Grafana Startup and Port Forwarding

**Challenge:** Grafana experienced repeated restarts and refused connections through port-forwarding.

**Resolution:** Adjusted startup probe allowances and resource requests, then accessed Grafana through an available local port.

**Learning:** Application startup time, health probes, and available cluster resources are important when operating monitoring services in resource-constrained environments.

## Security Considerations

- Sensitive Terraform state files are excluded from version control.
- Local environment files and private keys should never be committed.
- Credentials should be managed securely outside source code.
- Kubernetes and AWS permissions should follow least-privilege principles.

## Future Improvements

The following are planned enhancements rather than completed functionality:

- Deployment to Amazon EKS.
- Automated rollback and deployment verification.
- Container vulnerability scanning with Trivy.
- Prometheus Alertmanager integration.
- Kubernetes Horizontal Pod Autoscaling.
- GitOps-based deployments using Argo CD.
- Automated integration and smoke tests.

## Key Learnings

This project provided hands-on experience in:

- Integrating cloud-hosted Jenkins with a local Kubernetes deployment environment.
- Building and publishing container images.
- Deploying and troubleshooting Kubernetes workloads.
- Implementing application-level metrics collection.
- Configuring Prometheus service discovery.
- Building operational dashboards with Grafana.
- Investigating deployment failures, startup issues, and networking problems.

## Author

Shivangi Kapoor

DevOps | AWS | Terraform | Jenkins | Docker | Kubernetes | CI/CD | Monitoring

HOPE THIS REPO WILL BE HELPFULL FOR ANYONE WHO IS INTRESTED TO LEARN DEVOPS :) 
Happy Learning.
