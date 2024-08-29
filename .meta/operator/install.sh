#!/usr/bin/env bash

source ../utils.sh

function create_ns_with_sa() {
    kubectl apply -f namespace.yaml -f serviceaccount.yaml
}

function install_operator() {
    namespace="$(get_namespace)"
    helm install weblogic-operator weblogic-operator/weblogic-operator -n $namespace -f values.yaml 
}

function main() {
    create_ns_with_sa
    install_operator
}

main