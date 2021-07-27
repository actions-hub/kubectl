# kubectl

[![Preview](https://serhiy.s3.eu-central-1.amazonaws.com/Github_repo/kubectl/logo.png)](https://cloud.google.com)

GitHub Action for interacting with kubectl ([k8s](https://kubernetes.io))

## Usage
To use kubectl put this step into your workflow:

### Authorization with config file
```yaml
- uses: actions-hub/kubectl@master
  env:
    KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
  with:
    args: get pods
```

### Authorization with credentials
```yaml
- uses: actions-hub/kubectl@master
  env:
    KUBE_HOST: ${{ secrets.KUBE_HOST }}
    KUBE_CERTIFICATE: ${{ secrets.KUBE_CERTIFICATE }}
    KUBE_USERNAME: ${{ secrets.KUBE_USERNAME }}
    KUBE_PASSWORD: ${{ secrets.KUBE_PASSWORD }}
  with:
    args: get pods
```

### Authorization with a bearer token
```yaml
- uses: actions-hub/kubectl@master
  env:
    KUBE_HOST: ${{ secrets.KUBE_HOST }}
    KUBE_CERTIFICATE: ${{ secrets.KUBE_CERTIFICATE }}
    KUBE_TOKEN: ${{ secrets.KUBE_TOKEN }}
  with:
    args: get pods
```

## Environment variables
All these variables need to authorize to kubernetes cluster.  
I recommend using secrets for this.

### KUBECONFIG file
First options its to use [kubeconfig file](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/).  

For this method `KUBE_CONFIG` required.  
You can find it: `cat $HOME/.kube/config | base64 `.

Optionally you can switch the [context](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/) (the cluster) if you have few in kubeconfig file. Passing specific context to `KUBE_CONTEXT`. To see the list of available contexts do: `kubectl config get-contexts`.

| Variable | Type |
| --- | --- |
| KUBE_CONFIG | string (base64) |
| KUBE_CONTEXT | string |

### KUBECONFIG file
Another way to authenticate in the cluster is [HTTP basic auth](https://kubernetes.io/docs/reference/access-authn-authz/authentication/).
  
For this you need to pass:
- host (IP only, without protocol)
- username
- password
- cluster CA certificate

| Variable | Type |
| --- | --- |
| KUBE_HOST | string |
| KUBE_USERNAME | string |
| KUBE_PASSWORD | string |
| KUBE_CERTIFICATE | string |

## Example
```yaml
name: Get pods
on: [push]

jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v1
      - uses: actions-hub/kubectl@master
        env:
          KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
        with:
          args: get pods
```

```yaml
name: Get pods
on: [push]

jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v1
      - uses: actions-hub/kubectl@master
        env:
          KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}

      - uses: actions-hub/kubectl@master
        with:
          args: get pods
```

## Versions
If you need a specific version of kubectl, make a PR with a specific version number.
After accepting PR the new release will be created.   
To use a specific version of kubectl use:

```yaml
- uses: actions-hub/kubectl@1.14.3
  env:
    KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
  with:
    args: get pods
```

## Licence
[MIT License](https://github.com/actions-hub/kubectl/blob/master/LICENSE)