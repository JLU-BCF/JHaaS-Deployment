###########
# GENERAL
###########
variable "kubeconfig" {
  description = "Kubernetes configuration file to use"
}

variable "cm_issuer" {
  description = "value"
  default = "cluster-issuer"
}

variable "deploy_jhaas" {
  description = "value"
  default = true
}

variable "chart_jhaas_version" {
  description = "value"
  default = null
}

variable "jhaas_portal_fqdn" {
  description = "value"
}

variable "jhaas_name" {
  description = "value"
  default = "jhaas-portal"
}

variable "jhaas_namespace" {
  description = "value"
  default = "jhaas-portal"
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
  default = "redis://redis-master.redis"
}
variable "jhaas_redis_pass" {
  description = "value"
  default = null
}

###########
# Authentik
###########
variable "jhaas_authentik_url" {
  description = "value"
}
variable "jhaas_authentik_api_endpoint" {
  description = "value"
}
variable "jhaas_authentik_api_secret" {
  description = "value"
}
variable "jhaas_authentik_jupyter_hub_group" {
  description = "value"
  default = "jupyterhubs"
}
variable "jhaas_authentik_authentication_flow" {
  description = "jhaas-authentication"
  default = "jhaas-auth"
}
variable "jhaas_authentik_authorization_flow" {
  description = "value"
  default = "jhaas-consent"
}
variable "jhaas_authentik_icon" {
  description = "value"
  default = "/static/dist/assets/icons/icon.png"
}

###########
# DATABASE
###########
variable "jhaas_db_host" {
  description = "value"
}
variable "jhaas_db_port" {
  description = "value"
  default = "5432"
}
variable "jhaas_db_name" {
  description = "value"
  default = "jhaas"
}
variable "jhaas_db_user" {
  description = "value"
  default = "jhaas"
}
variable "jhaas_db_pass" {
  description = "value"
}

###########
# MAIL
###########
variable "jhaas_mail_host" {
  description = "value"
  default = ""
}
variable "jhaas_mail_port" {
  description = "value"
  default = ""
}
variable "jhaas_mail_secure" {
  description = "value"
  default = false
}
variable "jhaas_mail_from" {
  description = "value"
  default = ""
}
variable "jhaas_mail_from_name" {
  description = "value"
  default = ""
}
variable "jhaas_mail_copy_addresses" {
  description = "value"
  default = "[]"
}

###########
# S3
###########
variable "jhaas_s3_host" {
  description = "value"
  default = ""
}
variable "jhaas_s3_port" {
  description = "value"
  default = "80"
}
variable "jhaas_s3_ssl" {
  description = "value"
  default = false
}
variable "jhaas_s3_access_key" {
  description = "value"
  default = ""
}
variable "jhaas_s3_secret_key" {
  description = "value"
  default = ""
}
variable "jhaas_s3_api" {
  description = "value"
  default = "S3v2"
}
variable "jhaas_s3_bucket_tf_state" {
  description = "value"
  default = "tf-state"
}
variable "jhaas_s3_bucket_jh_specs" {
  description = "value"
  default = "jh-specs"
}

###########
# OIDC
###########
variable "jhaas_oidc_endpoint" {
  description = "value"
}
variable "jhaas_oidc_callback_url" {
  description = "value"
}
variable "jhaas_oidc_client_id" {
  description = "value"
}
variable "jhaas_oidc_client_secret" {
  description = "value"
}
