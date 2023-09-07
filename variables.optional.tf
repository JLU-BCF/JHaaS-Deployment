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
# AUTHENTIK CONFIGURATION
###############
variable "deploy_authentik" {
  description = "value"
  default = true
}

variable "authentik_path" {
  description = "Path where Authentik is accessible."
  default     = ""
}

variable "jhaas_path" {
  description = "Path where JHaaS is accessible."
  default     = ""
}

# OAuth Config
variable "authentik_jhaas_client_id" {
  description = "The client_id for the default jhaas provider."
  default     = "jhaas-portal"
}

variable "authentik_provider_redirect_uri" {
  description = "Allowed redirection URLs for jhaas provider. Will be generated. You may override it, if you want."
  default     = null
}

# Configure Flows
variable "authentik_jhaas_login_flow" {
  description = "URL for the JHaaS authentication flow."
  default     = "/if/flow/auth"
}

variable "authentik_flow_background" {
  description = "Default Background applied to all flows."
  default     = "/static/dist/assets/images/flow_background.jpg"
}

variable "authentik_tos_url" {
  description = "URL linked in TOS text"
  default     = null
}

variable "authentik_jhaas_login_redirect" {
  description = "URL for the JHaaS login redirect."
  default     = null
}

variable "authentik_jhaas_verify_redirect" {
  description = "URL for the JHaaS verify redirect."
  default     = null
}

variable "authentik_jhaas_launch_url" {
  description = "URL for the JHaaS launcher redirect."
  default     = null
}

# Configure Application
variable "authentik_jhaas_slogan" {
  description = "Slogan displayed for the JHaaS launcher."
  default     = "Your own JupyterHub, just a click away"
}

variable "authentik_branding_title" {
  description = "Title displayed by the web application."
  default     = "JHaaS"
}

variable "authentik_branding_favicon" {
  default = "/static/dist/assets/icons/icon.png"
}

variable "authentik_branding_logo" {
  default = "/static/dist/assets/icons/icon_left_brand.svg"
}

variable "authentik_branding_publisher" {
  default = ""
}

# Configure Mail Templates
variable "authentik_email_subject_enrollment" {
  default = "Verify you Email address for JHaaS"
}

variable "authentik_email_template_enrollment" {
  default = "email/account_confirmation.html"
}

variable "authentik_email_subject_recovery" {
  default = "Reset your password for JHaaS"
}

variable "authentik_email_template_recovery" {
  default = "email/password_reset.html"
}


###############
# JHaaS
###############