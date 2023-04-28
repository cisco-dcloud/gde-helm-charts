{{/*
Expand the name of the chart.
*/}}
{{- define "idac.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "idac.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "idac.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels 
*/}}
{{- define "idac.labels" -}}
helm.sh/chart: {{ include "idac.chart" . }}
{{ include "idac.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Common labels for UI
*/}}
{{- define "idac.auth.labels" -}}
helm.sh/chart: {{ include "idac.chart" . }}
{{ include "idac.auth.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels 
*/}}
{{- define "idac.selectorLabels" -}}
app.kubernetes.io/name: {{ include "idac.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for auth
*/}}
{{- define "idac.auth.selectorLabels" -}}
app.kubernetes.io/name: ui-{{ include "idac.name" . }}
app.kubernetes.io/instance: ui-{{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use for auth
*/}}
{{- define "idac.auth.serviceAccountName" -}}
{{- if .Values.auth.serviceAccount.create }}
{{- default (include "idac.fullname" .) .Values.auth.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.auth.serviceAccount.name }}
{{- end }}
{{- end }}
