# Instructions
## Prepare environment
1. Set values in .env
1. Source env.sh
```bash
source env.sh
```
### Setup operator and traefik ingress controller
[!NOTE]
This step is only requred if you haven't done that already on the same cluster
## Create secrets
```bash
cd manifests
./create-secrets.sh
```

## Create application archive
```bash
# ah is an alias for archiveHelper
ah add application -archive_file=$PWD/target/archive.zip -source=$PWD/app
```