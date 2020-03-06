{{/* vim: set filetype=mustache: */}}
{{/*
Create a short app name.
*/}}
{{- define "hbase-k8s.name" -}}
hbase
{{- end -}}

{{/*
Create a fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hbase-k8s.fullname" -}}
{{- if .Values.global.fullnameOverride -}}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "hbase-k8s.name" . -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the subchart label.
*/}}
{{- define "hbase-k8s.subchart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hbase-k8s.config.name" -}}
{{- template "hbase-k8s.name" . -}}-config
{{- end -}}

{{- define "hbase-k8s.config.fullname" -}}
{{- $fullname := include "hbase-k8s.fullname" . -}}
{{- if contains "config" $fullname -}}
{{- printf "%s" $fullname -}}
{{- else -}}
{{- printf "%s-config" $fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "hbase-k8s.master.name" -}}
{{- template "hbase-k8s.name" . -}}-master
{{- end -}}

{{- define "hbase-k8s.master.fullname" -}}
{{- $fullname := include "hbase-k8s.fullname" . -}}
{{- if contains "master" $fullname -}}
{{- printf "%s" $fullname -}}
{{- else -}}
{{- printf "%s-master" $fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "hbase-k8s.regionserver.name" -}}
{{- template "hbase-k8s.name" . -}}-regionserver
{{- end -}}

{{- define "hbase-k8s.regionserver.fullname" -}}
{{- $fullname := include "hbase-k8s.fullname" . -}}
{{- if contains "regionserver" $fullname -}}
{{- printf "%s" $fullname -}}
{{- else -}}
{{- printf "%s-regionserver" $fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "hbase-k8s.restserver.name" -}}
{{- template "hbase-k8s.name" . -}}-restserver
{{- end -}}

{{- define "hbase-k8s.restserver.fullname" -}}
{{- $fullname := include "hbase-k8s.fullname" . -}}
{{- if contains "restserver" $fullname -}}
{{- printf "%s" $fullname -}}
{{- else -}}
{{- printf "%s-restserver" $fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "hbase-k8s.thriftserver.name" -}}
{{- template "hbase-k8s.name" . -}}-thriftserver
{{- end -}}

{{- define "hbase-k8s.thriftserver.fullname" -}}
{{- $fullname := include "hbase-k8s.fullname" . -}}
{{- if contains "thriftserver" $fullname -}}
{{- printf "%s" $fullname -}}
{{- else -}}
{{- printf "%s-thriftserver" $fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create the domain name part of services.
The HDFS config file should specify FQDN of services. Otherwise, Kerberos
login may fail.
*/}}
{{- define "svc-domain" -}}
{{- printf "%s.svc.cluster.local" .Release.Namespace -}}
{{- end -}}

{{/*
Create the zookeeper quorum server list.  The below uses two loops to make
sure the last item does not have comma. It uses index 0 for the last item
since that is the only special index that helm template gives us.
*/}}
{{- define "zookeeper-quorum" -}}
{{- .Values.global.zookeeperQuorumOverride -}}
{{- end -}}

{{- define "hbase-rootdir" -}}
{{- .Values.global.hbaseRootdir -}}
{{- end -}}

{{- define "hdfs-k8s.config.fullname" -}}
{{- .Values.global.hdfsConfigMap -}}
{{- end -}}