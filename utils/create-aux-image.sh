#!/usr/bin/env bash

source .env
source utils/functions-aliases.sh

it createAuxImage \
    --tag $AUX_IMAGE_REPO:$AUX_IMAGE_TAG \
    --wdtModel model/model.yaml \
    --wdtVariables model/model.properties \
    --wdtArchive target/archive.zip

docker push $AUX_IMAGE_REPO:$AUX_IMAGE_TAG