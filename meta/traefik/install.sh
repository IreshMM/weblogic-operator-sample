#!/usr/bin/env bash

source ../utils.sh

function create_ns() {
    kubectl apply -f namespace.yaml
}

function install_traefik() {
    namespace=$(get_namespace)
    helm install traefik traefik/traefik --namespace $namespace --values values.yaml
}

function main() {
    create_ns
    install_traefik
}

main