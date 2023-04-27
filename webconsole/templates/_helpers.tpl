{{/*
Expand the name of the chart.
*/}}
{{- define "wc.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wc.fullname" -}}
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
{{- define "wc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels 
*/}}
{{- define "wc.labels" -}}
helm.sh/chart: {{ include "wc.chart" . }}
{{ include "wc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels for webConsole
*/}}
{{- define "wc.webConsole.labels" -}}
helm.sh/chart: {{ include "wc.chart" . }}
{{ include "wc.webConsole.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels for sshServer 
*/}}
{{- define "wc.sshServer.labels" -}}
helm.sh/chart: {{ include "wc.chart" . }}
{{ include "wc.sshServer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}








{{/*
Selector labels 
*/}}
{{- define "wc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wc.name" . }}
{{- end }}

{{/*
Selector labels for webConsole
*/}}
{{- define "wc.webConsole.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wc.name" . }}-webconsole
{{- end }}

{{/*
Selector labels for sshServer
*/}}
{{- define "wc.sshServer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wc.name" . }}-sshserver
{{- end }}






{{/*
Create the name for sshServer
*/}}
{{- define "wc.sshServer.fullname" -}}
{{ include "wc.name" . }}-sshserver
{{- end }}

{{/*
Create the name for webConsole
*/}}
{{- define "wc.webConsole.fullname" -}}
{{ include "wc.name" . }}-webconsole
{{- end }}




{{/*
Create the name of the service account to use sshServer
*/}}
{{- define "wc.sshServer.serviceAccountName" -}}
{{- if .Values.sshServer.serviceAccount.create }}
{{- default (include "wc.sshServer.fullname" .) .Values.sshServer.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.sshServer.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use for webConsole
*/}}
{{- define "wc.webConsole.serviceAccountName" -}}
{{- if .Values.webConsole.serviceAccount.create }}
{{- default (include "wc.webConsole.fullname" .) .Values.webConsole.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.webConsole.serviceAccount.name }}
{{- end }}
{{- end }}


