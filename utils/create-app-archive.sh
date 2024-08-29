#!/usr/bin/env bash

source .env
source utils/functions-aliases.sh

test -d target || mkdir target
ah add application -archive_file=target/archive.zip -source=app/myapp-v1