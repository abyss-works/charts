{{- define "abyss-app.namespace" -}}
{{- if .Values.namespace.name -}}
{{- .Values.namespace.name -}}
{{- else -}}
{{- printf "%s-%s" .Values.app .Values.environment -}}
{{- end -}}
{{- end -}}

{{- define "abyss-app.host" -}}
{{- if .Values.ingress.host -}}
{{- .Values.ingress.host -}}
{{- else if eq .Values.environment "prod" -}}
{{- printf "%s.abyssworks.dev" .Values.app -}}
{{- else -}}
{{- printf "%s-preview.abyssworks.dev" .Values.app -}}
{{- end -}}
{{- end -}}

{{- define "abyss-app.labels" -}}
abyssworks.dev/project: {{ .Values.app }}
abyssworks.dev/environment: {{ .Values.environment }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "abyss-app.selectorLabels" -}}
{{- if .Values.selectorLabels -}}
{{- toYaml .Values.selectorLabels -}}
{{- else -}}
app: {{ .Values.app }}
{{- end -}}
{{- end -}}

{{- define "abyss-app.priorityClassName" -}}
{{- if .Values.priorityClassName -}}
{{- .Values.priorityClassName -}}
{{- else if eq .Values.environment "prod" -}}
app-prod
{{- else -}}
batch-low
{{- end -}}
{{- end -}}

{{- define "abyss-app.cnpgClusterName" -}}
{{- if .Values.database.cnpg.name -}}
{{- .Values.database.cnpg.name -}}
{{- else -}}
{{- printf "%s-db" .Values.app -}}
{{- end -}}
{{- end -}}

{{- define "abyss-app.cnpgSecretName" -}}
{{- if .Values.database.cnpg.secretName -}}
{{- .Values.database.cnpg.secretName -}}
{{- else -}}
{{- printf "%s-app" (include "abyss-app.cnpgClusterName" .) -}}
{{- end -}}
{{- end -}}

{{- define "abyss-app.tlsSecretName" -}}
{{- if .Values.ingress.tls.secretName -}}
{{- .Values.ingress.tls.secretName -}}
{{- else -}}
{{- printf "%s-tls" .Values.app -}}
{{- end -}}
{{- end -}}
