#!/usr/bin/env bash

function get_namespace() {
    namespace=$(sed -n 's/.\+name: \(.\+\).*/\1/p' namespace.yaml)
    echo $namespace
}