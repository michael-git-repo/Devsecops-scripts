# Ports and Network Access

Ports below are the default ports for the tools installed by these scripts. The scripts do not add firewall rules, so configure your firewall or cloud security groups separately when remote access is needed.

## Local services

| Service | Port | Protocol | Purpose | Notes |
|---|---:|---|---|---|
| Jenkins | 8080 | TCP/HTTP | Web interface | Default Jenkins web port. |
| Jenkins agents | 50000 | TCP | Inbound agent connections | Optional; only needed if this agent connection method is enabled in Jenkins. |
| SonarQube | 9000 | TCP/HTTP | Web interface and API | Published by the script's Docker `-p 9000:9000` option. |
| Prometheus | 9090 | TCP/HTTP | Web interface and metrics API | Prometheus default web port. |
| Grafana | 3000 | TCP/HTTP | Web interface | Grafana default HTTP port. |

## Remote and outbound connections

| Service / use | Port | Protocol | Direction | Notes |
|---|---:|---|---|---|
| SSH for Ansible | 22 | TCP | Outbound from Ansible host to managed hosts | The scripts install Ansible but do not configure managed hosts. |
| EKS Kubernetes API | 443 | TCP/HTTPS | Outbound from kubectl/eksctl to the cluster endpoint | The endpoint and its access rules are managed by AWS. |
| Package and tool downloads | 443 | TCP/HTTPS | Outbound | Used to download packages and binaries. Some package repositories may also use port 80/TCP. |

Docker, Terraform, AWS CLI, kubectl, eksctl, and Trivy do not open a fixed inbound service port in these scripts. Docker is accessed through its local Unix socket by default; containers can use other ports when explicitly published.
