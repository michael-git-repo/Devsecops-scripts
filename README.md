# DevOps Installation Scripts

Bash scripts for installing and setting up common DevOps tools on Ubuntu-based Linux systems.

## Requirements

- Ubuntu or another compatible Debian-based Linux distribution
- A user account with `sudo` access
- An internet connection
- Bash and the standard system utilities used by the scripts

These scripts use `apt` and Linux-specific commands, so they are not intended to run directly in Windows PowerShell.

## Run the master installer

From the project root, run:

```bash
bash scripts/master-install.sh
```

The master installer runs these scripts in order:

1. `updating-upgrading.sh`
2. `docker.sh`
3. `jenkins.sh`
4. `trivy.sh`
5. `terraforma-and-asnible.sh`
6. `sonaqube.sh`
7. `eks-awscli-kubctl.sh`

It stops if a script fails. The `prometheus.sh` and `grafana.sh` installers are currently not called by the master installer; run them separately when needed:

```bash
bash scripts/prometheus.sh
bash scripts/grafana.sh
```

## Script inventory

| Script | Installs or configures |
|---|---|
| `updating-upgrading.sh` | System updates and prerequisite packages |
| `docker.sh` | Docker Engine and Compose plugins |
| `jenkins.sh` | Jenkins and Java 17 |
| `trivy.sh` | Trivy vulnerability scanner |
| `terraforma-and-asnible.sh` | Terraform and Ansible |
| `sonaqube.sh` | SonarQube in a Docker container |
| `prometheus.sh` | Prometheus system service |
| `grafana.sh` | Grafana system service |
| `eks-awscli-kubctl.sh` | AWS CLI v2, kubectl, and eksctl |

## Ports

See [ports.md](ports.md) for default service ports and network access notes. The scripts do not configure firewall rules or AWS security groups.
