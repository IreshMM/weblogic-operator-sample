#!/usr/bin/env bash

source .env

kubectl create -n $SAMPLE_NS secret docker-registry $OCR_SECRET_NAME \
    --docker-server=$OCR_SERVER \
    --docker-username=$OCR_USERNAME \
    --docker-password=$OCR_TOKEN

kubectl create -n $SAMPLE_NS secret generic $WEBLOGIC_CRED_SECRET_NAME \
    --from-literal=username=$WEBLOGIC_CRED_USERNAME \
    --from-literal=password=$WEBLOGIC_CRED_PASSWORD
kubectl label -n $SAMPLE_NS secret $WEBLOGIC_CRED_SECRET_NAME weblogic.domainUID=$WEBLOGIC_DOMAIN_UID

kubectl create -n $SAMPLE_NS secret generic $WEBLOGIC_DOMAIN_RUNTIME_ENC_SECRET_NAME \
    --from-literal=password=$WEBLOGIC_DOMAIN_RUNTIME_ENC_SECRET
kubectl label -n $SAMPLE_NS secret $WEBLOGIC_DOMAIN_RUNTIME_ENC_SECRET_NAME weblogic.domainUID=$WEBLOGIC_DOMAIN_UID