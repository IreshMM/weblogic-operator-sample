#!/usr/bin/env bash

set -a
source .env
set +a

source utils/functions-aliases.sh

ekapply manifests/ingress/domain1-cluster-cluster-1.yaml