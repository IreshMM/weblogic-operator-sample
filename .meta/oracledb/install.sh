#!/usr/bin/env bash

source ../utils.sh

# Source the environment variables
source ../../.env

# Create namespace
kubectl apply -f namespace.yaml

# Create image pull secret
namespace=$(get_namespace)
kubectl create -n $namespace secret docker-registry $OCR_SECRET_NAME \
    --docker-server=$OCR_SERVER \
    --docker-username=$OCR_USERNAME \
    --docker-password=$OCR_TOKEN

kubectl create -n $namespace secret generic oracle-db-secret \
    --from-literal='password=passw0rd'

kubectl apply -f deployment.yaml -f service.yaml