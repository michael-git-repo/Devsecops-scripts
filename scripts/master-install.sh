#!/bin/bash
set -e

cd "$(dirname "$0")"

bash updating-upgrading.sh
bash docker.sh
bash jenkins.sh
bash trivy.sh
bash terraforma-and-asnible.sh
bash sonaqube.sh
bash eks-awscli-kubctl.sh