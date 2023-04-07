# Usage

```yaml
jobs:
  # ...
  staging:
    name: "Deploy to staging"
    runs-on: self-hosted
    needs: ['setup', 'build']
    steps:
      - uses: orderlycode/k8s-deploy-action@main
        with:
          kubeConfig: ${{ secrets.K8S_STAGING }}
          name: ${{ needs.setup.outputs.app_name }}
          image: ${{ needs.setup.outputs.image }}
```
