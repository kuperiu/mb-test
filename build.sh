#!/bin/bash
[ $# -eq 0 ] && { echo "Usage: $0 [project name]"; exit 1; }
PROJECT=$1
pushd infra
terraform init 
terraform plan --var="project_name=$PROJECT" --out=tfplan
terraform apply "tfplan"
popd
gcloud container clusters get-credentials $PROJECT --zone us-central1-a --project $PROJECT
#a fix for rbac on GKE
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)
kubectl apply -f k8s/
echo "Waiting for k8s resources to create"
sleep 150
PROMETHEUS_IP=$(kubectl get svc prometheus-1-prometheus -o jsonpath="{.status.loadBalancer.ingress[*].ip}")
MB_IP=$(kubectl get svc mb-test-svc -o jsonpath="{.status.loadBalancer.ingress[*].ip}")
open http://$MB_IP/homersimpson
open http://$MB_IP/covilha
open http://$PROMETHEUS_IP:9090