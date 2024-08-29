# Instructions
## Prepare environment
1. Set values in .env
1. Source env.sh
```bash
source env.sh
```
### Setup operator and traefik ingress controller
> [!NOTE]
> This step is only requred if you haven't done that already on the same cluster

```bash
cd .meta/operator
./install.sh
```
```bash
cd .meta/traefik
./install.sh
```

## Create namespace
```bash
# ekapply is a shell function defined in utils/functions-aliases.sh
ekapply namespace.yaml
```

## Create secrets
```bash
utils/create-secrets.sh
```

## Create application archive
```bash
utils/create-app-archive.sh
```

## Create auxillary image
```bash
utils/create-aux-image.sh
```

## Create domain
```bash
utils/create-domain.sh
```