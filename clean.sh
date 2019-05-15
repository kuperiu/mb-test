#!/bin/bash
set -e
[ $# -eq 0 ] && { echo "Usage: $0 [project name]"; exit 1; }
PROJECT=$1
kubectl delete -f k8s/
pushd infra
terraform destroy --var="project_name=$PROJECT"
popd