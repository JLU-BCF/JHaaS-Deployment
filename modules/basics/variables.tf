###############
# COMMON
###############
variable "kubeconfig" {
  description = "Kubernetes configuration file to use"
}

###############
# VERSIONS
###############
variable "chart_certmanager_version" {
  description = "value"
  default     = null
}
variable "chart_ingress_version" {
  description = "value"
  default     = null
}
variable "chart_minio_version" {
  description = "value"
  default     = null
}
variable "chart_postgres_version" {
  description = "value"
  default     = null
}
variable "chart_redis_version" {
  description = "value"
  default     = null
}
variable "chart_datashim_version" {
  description = "value"
  default     = null
}
variable "chart_nfs_provisioner_version" {
  description = "value"
  default     = null
}

###############
# CERT-MANAGER
###############
variable "deploy_cert_manager" {
  description = "Whether to deploy cert manager"
  default     = true
}

variable "cm_issuer_email" {
  description = "email address to use for certmanager issuer"
  default     = null
}

variable "cm_namespace" {
  description = "Namespace to be used for cert-manager"
  default     = "cert-manager"
}

variable "cm_name" {
  description = "Name to be used for cert-manager"
  default     = "cert-manager"
}

variable "cm_issuer" {
  description = "Name for the default cert-manager cluster issuer"
  default     = "cluster-issuer"
}

variable "cm_issuer_server" {
  description = "The ACME server URL"
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}

###############
# NGINX-INGRESS
###############
variable "deploy_nginx_ingress_controller" {
  description = "Whether to deploy nginx ingress controller"
  default     = true
}

variable "ingress_namespace" {
  description = "Namespace for nginx ingress"
  default     = "nginx-ingress"
}

variable "ingress_name" {
  description = "Name for nginx ingress"
  default     = "nginx-ingress"
}

###############
# POSTGRES
###############
variable "deploy_postgres" {
  description = "Whether to deploy postgres DB"
  default     = true
}

variable "postgres_namespace" {
  description = "Namespace to be used for postgres"
  default     = "postgres"
}

variable "postgres_name" {
  description = "value"
  default     = "postgres"
}

variable "jhaas_db_user" {
  description = "value"
  default     = "jhaas"
}

variable "jhaas_db_pass" {
  description = "value"
}

variable "jhaas_db_name" {
  description = "value"
  default     = "jhaas"
}

variable "authentik_db_user" {
  description = "value"
  default     = "authentik"
}

variable "authentik_db_pass" {
  description = "value"
}

variable "authentik_db_name" {
  description = "value"
  default     = "authentik"
}

###############
# REDIS
###############
variable "deploy_redis" {
  description = "value"
  default     = true
}

variable "redis_namespace" {
  description = "value"
  default     = "redis"
}

variable "redis_name" {
  description = "value"
  default     = "redis"
}

variable "redis_pass" {
  description = "value"
}

###############
# MINIO
###############
variable "deploy_minio" {
  description = "value"
  default     = true
}

variable "minio_namespace" {
  description = "value"
  default     = "minio"
}

variable "minio_name" {
  description = "value"
  default     = "minio"
}

variable "minio_user" {
  description = "value"
}

variable "minio_pass" {
  description = "value"
}

variable "minio_buckets" {
  description = "comma-seperated list of buckets"
  default     = "tf-state,jh-specs"
}

###############
# DATASHIM
###############
variable "deploy_datashim" {
  description = "value"
  default     = true
}

variable "datashim_namespace" {
  description = "value"
  default     = "datashim"
}

variable "datashim_name" {
  description = "value"
  default     = "datashim"
}

variable "jhaas_s3_data_secret_name" {
  description = "value"
  default     = "jhaas-s3-data-conf"
}

###############
# S3 DATA SECRET FOR DATASHIM
###############
variable "jhaas_s3_data_host" {
  description = "value"
  default     = null
}

variable "jhaas_s3_data_port" {
  description = "value"
  default     = null
}

variable "jhaas_s3_data_ssl" {
  description = "value"
  default     = null
}

variable "jhaas_s3_data_access_key" {
  description = "value"
  default     = null
}

variable "jhaas_s3_data_secret_key" {
  description = "value"
  default     = null
}

###############
# NFS PROVISIONER
###############
variable "deploy_nfs_provisioner" {
  description = "Whether to deploy nfs provisioner"
  default     = true
}

variable "nfs_provisioner_name" {
  description = "Name for nfs provisioner"
  default     = "nfs-provisioner"
}

variable "nfs_provisioner_namespace" {
  description = "Namespace for nfs provisioner"
  default     = "nfs-provisioner"
}

variable "nfs_storage_size" {
  description = "Storage for nfs provisioner"
  default     = "30Gi"
}

variable "nfs_storageclass_name" {
  description = "Name for nfs provisioners storage class"
  default     = "local-nfs"
}
