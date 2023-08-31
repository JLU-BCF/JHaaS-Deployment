###############
# CERT-MANAGER
###############
variable "deploy_cert_manager" {
  description = "Whether to deploy cert manager"
  default = true
}

variable "cm_namespace" {
    description = "Namespace to be used for cert-manager"
    default = "cert-manager"
}

variable "cm_issuer" {
    description = "Name for the default cert-manager cluster issuer"
    default = "cluster-issuer"
}

###############
# NGINX-INGRESS
###############
variable "deploy_nginx_ingress_controller" {
  description = "Whether to deploy nginx ingress controller"
  default = true
}

variable "ingress_namespace" {
    description = "Namespace for nginx ingress"
    default = "nginx-ingress"
}

###############
# POSTGRES
###############
variable "deploy_postgres" {
  description = "Whether to deploy postgres DB"
  default = true
}

variable "postgres_namespace" {
    description = "Namespace to be used for postgres"
    default = "postgres"
}

variable "postgres_name" {
  description = "value"
  default = "postgres"
}

variable "jhaas_db_name" {
  description = "value"
  default = "jhaas"
}

variable "jhaas_db_user" {
  description = "value"
  default = "jhaas"
}

###############
# REDIS
###############
variable "deploy_redis" {
  description = "value"
  default = true
}

variable "redis_namespace" {
  description = "value"
  default = "redis"
}

variable "redis_name" {
  description = "value"
  default = "redis"
}

###############
# MINIO
###############
variable "deploy_minio" {
  description = "value"
  default = true
}

variable "minio_namespace" {
  description = "value"
  default = "minio"
}

variable "minio_name" {
  description = "value"
  default = "minio"
}

variable "minio_buckets" {
  description = "comma-seperated list of buckets"
  default = "tf-state,jh-specs"
}

###############
# AUTHENTIK
###############
variable "authentik_kubeconfig" {
  description = "Set if you want to deploy authentik somewhere else"
  default = null
}

variable "authentik_namespace" {
  description = "value"
  default = "authentik"
}

variable "authentik_name" {
  description = "value"
  default = "authentik"
}

variable "authentik_log_level" {
  description = "value"
  default = "info"
}

variable "authentik_blueprints_override_name" {
  description = "value"
  default = "authentik-blueprints-override"
}

variable "authentik_cm_issuer" {
  description = "Set if it differs"
  default = null
}

# DATABASE

variable "authentik_db_host" {
  description = "Generated if internal db is used. Set if external db is used."
  default = null
}

variable "authentik_db_port" {
  description = "value"
  default = 5432
}

variable "authentik_db_name" {
  description = "value"
  default = "authentik"
}

variable "authentik_db_user" {
  description = "value"
  default = "authentik"
}

variable "authentik_db_pass" {
  description = "Generated if internal db is used. Set if external db is used."
  default = null
}

# REDIS

variable "authentik_redis_host" {
  description = "Generated if internal db is used. Set if external db is used."
  default = null
}

variable "authentik_redis_pass" {
  description = "Generated if internal db is used. Set if external db is used."
  default = null
}

# MAIL

variable "authentik_mail_host" {
  description = "value"
  default = ""
}

variable "authentik_mail_port" {
  description = "value"
  default =  587
}

variable "authentik_mail_use_ssl" {
  description = "value"
  default = false
}

variable "authentik_mail_use_tls" {
  description = "value"
  default = false
}

variable "authentik_mail_username" {
  description = "value"
  default = ""
}

variable "authentik_mail_password" {
  description = "value"
  default = ""
}

variable "authentik_mail_from" {
  description = "value"
  default = ""
}

###############
# JHaaS
###############
