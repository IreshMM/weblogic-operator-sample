#!/usr/bin/env bash

source .env

alias it=$PWD/tools/imagetool/bin/imagetool.sh
alias ah=$PWD/tools/weblogic-deploy/bin/archiveHelper.sh
wdt=$PWD/tools/weblogic-deploy.zip

docker login -u $OCR_USERNAME -p $OCR_TOKEN $OCR_SERVER