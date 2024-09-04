#!/usr/bin/env bash

source .env

source utils/functions-aliases.sh

kubectl -n $SAMPLE_NS create configmap $WEBLOGIC_MODEL_CONFIGMAP_NAME \
    --from-file=model/updates/datasource.yaml