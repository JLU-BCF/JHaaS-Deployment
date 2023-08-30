###############
# COMMON
###############
variable "kubeconfig" {
    description = "Kubernetes configuration file to use"
}

###############
# CERT-MANAGER
###############
variable "deploy_cert_manager" {
  description = "Whether to deploy cert manager"
  default = true
}

variable "issuer_email" {
    description = "email address to use for certmanager issuer"
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

variable "jhaas_db_user" {
  description = "value"
  default = "jhaas"
}

variable "jhaas_db_pass" {
  description = "value"
  default = "jhaas"
}

variable "jhaas_db_name" {
  description = "value"
  default = "jhaas"
}

variable "authentik_db_user" {
  description = "value"
  default = "authentik"
}

variable "authentik_db_pass" {
  description = "value"
  default = "authentik"
}

variable "authentik_db_name" {
  description = "value"
  default = "authentik"
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

variable "redis_pass" {
  description = "value"
  default = "to-be-generated"
}
