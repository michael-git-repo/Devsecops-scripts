#!/bin/bash
set -e

cd "$(dirname "$0")"

bash updating-upgrading.sh
rm updating-upgrading.sh

bash docker.sh
rm docker.sh

bash jenkins.sh
rm jenkins.sh

bash trivy.sh
rm trivy.sh

bash terraforma-and-asnible.sh
rm terraforma-and-asnible.sh

bash sonaqube.sh
rm sonaqube.sh

bash prometheus.sh
rm prometheus.sh

bash grafana.sh
rm grafana.sh

bash eks-awscli-kubctl.sh
rm eks-awscli-kubctl.sh

rm master-install.sh
