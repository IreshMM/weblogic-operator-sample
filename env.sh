#!/usr/bin/env bash

set -a
source .env
set +a

source utils/functions-aliases.sh

docker login -u $OCR_USERNAME -p $OCR_TOKEN $OCR_SERVER

it cache deleteEntry --key wdt_latest
it cache addInstaller --type wdt --version latest --path $wdt