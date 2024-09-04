# Initial Phase
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
ekapply manifests/namespace.yaml
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

## Create ingress
```bash
utils/create-ingress.sh
```

## Test
```bash
CLUSTER_LB_IP=$(kubectl get svc traefik -n traefik -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
CLUSTER_LB_PORT=$(kubectl get svc traefik -n traefik -o 'jsonpath={.spec.ports[?(@.name=="web")].port}')
curl $CLUSTER_LB_IP:$CLUSTER_LB_PORT/myapp_war/index.jsp -H 'host: weblogic-domain.weblogic-sample.sample'
```

# Update 1

##  Create oracle DB instance
```bash
cd .meta/oracle-db
./install.sh
```

## Create new secrets
```bash
utils/create-secrets.sh
```

## Create new model ConfigMap
```bash
utils/create-model-configmap.sh
```

## Apply new changes to the domain
```bash
utils/apply-domain.sh
```

## Roll the domain
```bash
# Applying after patching the domain restartVersion
utils/roll-domain.sh
```

# Contains licensed content from oracle:
- [Weblogic Kubernetes Operator Docs](https://oracle.github.io/weblogic-kubernetes-operator/)
- [Weblogic Kubernetes Operator Source](https://github.com/oracle/weblogic-kubernetes-operator)
- [Weblogic Deploy Tooling](https://oracle.github.io/weblogic-deploy-tooling)
- [Weblogic Deploy Tooling Source](https://github.com/oracle/weblogic-deploy-tooling)

Please consult the respective sources for licensing information.