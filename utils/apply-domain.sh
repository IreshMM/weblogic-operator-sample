#!/usr/bin/env bash

set -a
source .env
set +a

source utils/functions-aliases.sh

ekapply manifests/{domain.yaml,cluster.yaml}