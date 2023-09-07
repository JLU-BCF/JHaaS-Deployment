###########
# GENERAL
###########
variable "kubeconfig" {
  description = "Kubernetes configuration file to use"
}

variable "jhaas_portal_fqdn" {
  description = "value"
}

variable "deploy_jhaas" {
  description = "value"
  default = true
}

variable "jhaas_name" {
  description = "value"
  default = "jhaas-portal"
}

variable "jhaas_namespace" {
  description = "value"
  default = "jhaas-portal"
}

variable "cm_issuer" {
  description = "value"
  default = "cluster-issuer"
}

###########
# Registry Stuff
###########
variable "jhaas_helm_registry_host" {
  description = "value"
  default = "git.computational.bio.uni-giessen.de"
}
variable "jhaas_helm_registry_user" {
  description = "value"
  default = null
}
variable "jhaas_helm_registry_pass" {
  description = "value"
  default = null
}
variable "jhaas_image_credentials_registry" {
  description = "value"
}

variable "jhaas_image_credentials_user" {
  description = "value"
}

variable "jhaas_image_credentials_pass" {
  description = "value"
}

###########
# BACKEND
###########
variable "jhaas_backend_jh_domain" {
  description = "value"
}
variable "jhaas_k8s_tf_image" {
  description = "value"
  default = "harbor.computational.bio.uni-giessen.de/jhaas/tf-worker:master"
}
variable "jhaas_frontend_url" {
  description = "value"
}
variable "jhaas_session_cookie_secret" {
  description = "value"
}
variable "jhaas_redis_url" {
  description = "value"
  default = "redis://redis.redis"
}
