###############
# MAIL
###############
variable "mail_host" {
  description = "value"
  default     = ""
}
variable "mail_port" {
  description = "value"
  default     = "587"
}
variable "mail_ssl" {
  description = "value"
  default     = false
}
variable "mail_tls" {
  description = "value"
  default     = false
}
variable "mail_from" {
  description = "value"
  default     = ""
}
variable "mail_from_name" {
  description = "value"
  default     = ""
}
variable "mail_username" {
  description = "value"
  default     = ""
}
variable "mail_password" {
  description = "value"
  default     = ""
}
###############
# CERT-MANAGER
###############
variable "deploy_cert_manager" {
  description = "Whether to deploy cert manager"
  default     = true
}

variable "cm_namespace" {
  description = "Namespace to be used for cert-manager"
  default     = "cert-manager"
}

variable "cm_issuer" {
  description = "Name for the default cert-manager cluster issuer"
  default     = "cluster-issuer"
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

variable "minio_buckets" {
  description = "comma-seperated list of buckets"
  default     = "tf-state,jh-specs"
}

###############
# AUTHENTIK
###############
variable "authentik_kubeconfig" {
  description = "Set if you want to deploy authentik somewhere else"
  default     = null
}

variable "authentik_namespace" {
  description = "value"
  default     = "authentik"
}

variable "authentik_name" {
  description = "value"
  default     = "authentik"
}

variable "authentik_display_name" {
  description = "value"
  default     = "Authentik"
}

variable "authentik_bootstrap_mail" {
  description = "value"
  default     = "akadmin@jhaas.intern"
}

variable "authentik_log_level" {
  description = "value"
  default     = "info"
}

variable "authentik_blueprints_override_name" {
  description = "value"
  default     = "authentik-blueprints-override"
}

variable "authentik_cm_issuer" {
  description = "Set if it differs"
  default     = null
}

# DATABASE

variable "authentik_db_host" {
  description = "Generated if internal db is used. Set if external db is used."
  default     = null
}

variable "authentik_db_port" {
  description = "value"
  default     = "5432"
}

variable "authentik_db_name" {
  description = "value"
  default     = "authentik"
}

variable "authentik_db_user" {
  description = "value"
  default     = "authentik"
}

variable "authentik_db_pass" {
  description = "Generated if internal db is used. Set if external db is used."
  default     = null
}

# REDIS

variable "authentik_redis_host" {
  description = "Generated if internal db is used. Set if external db is used."
  default     = null
}

variable "authentik_redis_pass" {
  description = "Generated if internal db is used. Set if external db is used."
  default     = null
}

# MAIL

variable "authentik_mail_host" {
  description = "value"
  default     = null
}

variable "authentik_mail_port" {
  description = "value"
  default     = null
}

variable "authentik_mail_use_ssl" {
  description = "value"
  default     = null
}

variable "authentik_mail_use_tls" {
  description = "value"
  default     = null
}

variable "authentik_mail_username" {
  description = "value"
  default     = null
}

variable "authentik_mail_password" {
  description = "value"
  default     = null
}

variable "authentik_mail_from" {
  description = "value"
  default     = null
}

###############
# AUTHENTIK CONFIGURATION
###############
variable "deploy_authentik" {
  description = "value"
  default     = true
}

variable "create_authentik_namespace" {
  description = "value"
  default     = true
}

variable "configure_authentik" {
  description = "value"
  default     = true
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
  default = "account_confirmation.html"
}

variable "authentik_email_subject_recovery" {
  default = "Reset your password for JHaaS"
}

variable "authentik_email_template_recovery" {
  default = "password_reset.html"
}

variable "authentik_email_subject_mfa_recovery" {
  default = "Reset MFA for your Account"
}

variable "authentik_email_template_mfa_recovery" {
  default = "mfa_reset.html"
}


###############
# JHaaS
###############
variable "jhaas_image_credentials" {
  description = "An Array of { name: string, registry: string, username: string, password: string }"
  default     = []
}
variable "jhaas_backend_image_name" {
  description = "value"
  default     = "harbor.computational.bio.uni-giessen.de/jhaas/portal-backend:master"
}
variable "jhaas_frontend_image_name" {
  description = "value"
  default     = "harbor.computational.bio.uni-giessen.de/jhaas/portal-frontend:master"
}
variable "deploy_jhaas" {
  description = "value"
  default     = true
}
variable "create_jhaas_namespace" {
  description = "value"
  default     = true
}
variable "jhaas_namespace" {
  description = "value"
  default     = "jhaas-portal"
}
variable "jhaas_name" {
  description = "value"
  default     = "jhaas-portal"
}
variable "jhaas_kubeconfig" {
  description = "Set if you want to deploy jhaas somewhere else"
  default     = null
}
variable "jhaas_kubeconfig_hubs" {
  description = "Set if you want to deploy hubs somewhere else"
  default     = null
}
variable "jhaas_cm_issuer" {
  description = "Set if it differs"
  default     = null
}
variable "jhaas_cm_issuer_hubs" {
  description = "value"
  default     = null
}
variable "jhaas_backend_jh_domain" {
  description = "value"
  default     = null
}
variable "jhaas_k8s_tf_image" {
  description = "value"
  default     = "harbor.computational.bio.uni-giessen.de/jhaas/tf-worker:master"
}
# JHaaS Redis
variable "jhaas_redis_url" {
  description = "value"
  default     = null
}
variable "jhaas_redis_pass" {
  description = "value"
  default     = null
}
# JHaaS Authentik
variable "jhaas_authentik_jupyter_hub_group" {
  description = "value"
  default     = "jupyter"
}
variable "jhaas_authentik_authentication_flow" {
  description = "value"
  default     = "auth"
}
variable "jhaas_authentik_authorization_flow" {
  description = "value"
  default     = "consent"
}
variable "jhaas_authentik_invalidation_flow" {
  description = "value"
  default     = "logout"
}
variable "jhaas_authentik_icon" {
  description = "value"
  default     = "/static/dist/assets/icons/icon.png"
}
# JHaaS DB
variable "jhaas_db_host" {
  description = "value"
  default     = null
}
variable "jhaas_db_port" {
  description = "value"
  default     = "5432"
}
variable "jhaas_db_name" {
  description = "value"
  default     = "jhaas"
}
variable "jhaas_db_user" {
  description = "value"
  default     = "jhaas"
}
variable "jhaas_db_pass" {
  description = "value"
  default     = null
}
# JHaaS Mail
variable "jhaas_mail_host" {
  description = "value"
  default     = null
}
variable "jhaas_mail_port" {
  description = "value"
  default     = null
}
variable "jhaas_mail_secure" {
  description = "value"
  default     = null
}
variable "jhaas_mail_from" {
  description = "value"
  default     = null
}
variable "jhaas_mail_from_name" {
  description = "value"
  default     = null
}
variable "jhaas_mail_copy_addresses" {
  description = "value"
  default     = "[]"
}
variable "jhaas_mail_feedback_address" {
  description = "value"
  default     = null
}
# JHaaS S3
variable "jhaas_s3_host" {
  description = "value"
  default     = null
}
variable "jhaas_s3_port" {
  description = "value"
  default     = "9000"
}
variable "jhaas_s3_ssl" {
  description = "value"
  default     = false
}
variable "jhaas_s3_access_key" {
  description = "value"
  default     = null
}
variable "jhaas_s3_secret_key" {
  description = "value"
  default     = null
}
variable "jhaas_s3_api" {
  description = "value"
  default     = "S3v2"
}
variable "jhaas_s3_bucket_tf_state" {
  description = "value"
  default     = "tf-state"
}
variable "jhaas_s3_bucket_jh_specs" {
  description = "value"
  default     = "jh-specs"
}

###############
# JHaaS User Docs
###############
variable "deploy_jhaas_user_docs" {
  description = "value"
  default     = true
}
variable "jhaas_user_docs_cm_issuer" {
  description = "Set if it differs"
  default     = null
}
variable "jhaas_user_docs_name" {
  description = "value"
  default     = "jhaas-user-docs"
}
variable "jhaas_user_docs_namespace" {
  description = "value"
  default     = "jhaas-user-docs"
}
variable "jhaas_user_docs_image_name" {
  description = "value"
  default     = "harbor.computational.bio.uni-giessen.de/jhaas/user:master"
}
