# abyss-works Helm Charts

Shared Helm chart monorepo for `abyss-works` services.

## Repository Structure

```text
charts/
  <chart-name>/
    Chart.yaml
    values.yaml
    values.schema.json
    templates/
    examples/
```

Each chart lives under `charts/<chart-name>/` (for example, `charts/abyss-app/`).

## Release Tag Convention

Charts are versioned independently using per-chart Git tags:

```text
<chart-name>-vX.Y.Z
```

Example: `abyss-app-v0.1.0`

## Argo CD Multi-Source Usage

Consume a pinned chart release alongside app-specific values files using Argo CD `spec.sources`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app-preview
  namespace: argocd
spec:
  project: my-app
  destination:
    server: https://kubernetes.default.svc
    namespace: my-app-preview
  sources:
    - repoURL: https://github.com/abyss-works/charts
      path: charts/abyss-app
      targetRevision: abyss-app-v0.1.0
      helm:
        valueFiles:
          - $values/k8s/values-preview.yaml
    - repoURL: https://github.com/abyss-works/my-app
      targetRevision: dev
      ref: values
```

Standard environment names are `prod` (`main` branch, `values-prod.yaml`) and `preview` (`dev` branch, `values-preview.yaml`).

## Local Validation

```sh
helm lint charts/abyss-app
helm template my-app charts/abyss-app -f charts/abyss-app/examples/values-hamsudoku-preview.yaml \
  | kubeconform -strict -ignore-missing-schemas -summary
```
