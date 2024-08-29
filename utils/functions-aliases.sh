#!/usr/bin/env basjh

shopt -s expand_aliases

alias it=$PWD/tools/imagetool/bin/imagetool.sh
alias ah=$PWD/tools/weblogic-deploy/bin/archiveHelper.sh
wdt=$PWD/tools/weblogic-deploy.zip

function ekapply() {
    files="$@"
    for file in $files; do
        envsubst < $file | kubectl apply -f -
    done
}