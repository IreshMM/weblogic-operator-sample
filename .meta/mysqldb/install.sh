#!/usr/bin/env bash

source ../utils.sh

# Source the environment variables
source ../../.env

# Create namespace
kubectl apply -f namespace.yaml

namespace=$(get_namespace)
kubectl create -n $namespace secret generic mysql-secret \
    --from-literal='user=root' \
    --from-literal='password=passw0rd'

kubectl apply -f deployment.yaml -f service.yaml