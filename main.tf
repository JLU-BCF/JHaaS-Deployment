provider "helm" {
  # alias  = "helm-basics"

  kubernetes {
    config_path = var.kubeconfig
  }
}

provider "kubernetes" {
  # alias  = "kubernetes-basics"

  config_path = var.kubeconfig
}

provider "kubectl" {
  # alias  = "kubectl-basics"

  config_path = var.kubeconfig
}

# internal service urls
locals {
  postgres_url = "${var.postgres_name}.${var.postgres_namespace}"
  redis_url = "${var.redis_name}-master.${var.redis_namespace}"
  minio_url = "${var.minio_name}.${var.minio_namespace}"
  portal_url = "https://${var.portal_fqdn}/"
  authentik_url = "https://${var.authentik_fqdn}/"
  authentik_api_url = "https://${var.authentik_fqdn}/api/v3"
}

# authentik
locals {
  # static overrides
  authentik_kubeconfig = var.authentik_kubeconfig == null ? var.kubeconfig : var.authentik_kubeconfig
  authentik_cm_issuer = var.authentik_cm_issuer == null ? var.cm_issuer : var.authentik_cm_issuer
  authentik_db_host = var.authentik_db_host == null ? local.postgres_url : var.authentik_db_host
  authentik_redis_host = var.authentik_redis_host == null ? local.redis_url : var.authentik_redis_host

  # generated overrides
  authentik_db_pass = var.authentik_db_pass == null ? random_password.authentik_db_pass.result : var.authentik_db_pass
  authentik_redis_pass = var.authentik_redis_pass == null ? random_password.redis_pass.result : var.authentik_redis_pass
}

# jhaas
locals {
  # static overrides
  jhaas_kubeconfig = var.jhaas_kubeconfig == null ? var.kubeconfig : var.jhaas_kubeconfig
  jhaas_cm_issuer = var.jhaas_cm_issuer == null ? var.cm_issuer : var.jhaas_cm_issuer
  jhaas_db_host = var.jhaas_db_host == null ? local.postgres_url : var.jhaas_db_host
  jhaas_redis_url = var.jhaas_redis_url == null ? local.redis_url : var.jhaas_redis_url

  # generated overrides
  jhaas_db_pass = var.jhaas_db_pass == null ? random_password.jhaas_db_pass.result : var.jhaas_db_pass
  jhaas_redis_pass = var.jhaas_redis_pass == null ? random_password.redis_pass.result : var.jhaas_redis_pass
}

# jhaas s3
locals {
  jhaas_s3_host = var.jhaas_s3_host == null ? local.minio_url : var.jhaas_s3_host
  jhaas_s3_access_key = var.jhaas_s3_access_key == null ? random_pet.minio_user.id : var.jhaas_s3_access_key
  jhaas_s3_secret_key = var.jhaas_s3_secret_key == null ? random_password.minio_pass.result : var.jhaas_s3_secret_key
}

module "basics" {
  source = "./modules/basics"

  # providers = {
  #   helm = "helm-basics"
  #   kubernetes = "kubernetes-basics"
  #   kubectl = "kubectl-basics"
  # }

  kubeconfig = var.kubeconfig

  deploy_cert_manager = var.deploy_cert_manager
  cm_issuer_email     = var.cm_issuer_email
  cm_namespace        = var.cm_namespace
  cm_issuer           = var.cm_issuer

  deploy_nginx_ingress_controller = var.deploy_nginx_ingress_controller
  ingress_namespace               = var.ingress_namespace

  deploy_postgres     = var.deploy_postgres
  postgres_namespace  = var.postgres_namespace
  postgres_name       = var.postgres_name
  jhaas_db_user       = var.jhaas_db_user
  jhaas_db_pass       = random_password.jhaas_db_pass.result
  jhaas_db_name       = var.jhaas_db_name
  authentik_db_user   = var.authentik_db_user
  authentik_db_pass   = random_password.authentik_db_pass.result
  authentik_db_name   = var.authentik_db_name

  deploy_redis    = var.deploy_redis
  redis_namespace = var.redis_namespace
  redis_name      = var.redis_name
  redis_pass      = random_password.redis_pass.result

  deploy_minio    = var.deploy_minio
  minio_namespace = var.minio_namespace
  minio_name      = var.minio_name
  minio_user      = random_pet.minio_user.id
  minio_pass      = random_password.minio_pass.result
  minio_buckets   = var.minio_buckets
}

module "authentik-deployment" {
  source = "./modules/authentik-deployment"

  deploy_authentik = var.deploy_authentik

  kubeconfig = local.authentik_kubeconfig
  cm_issuer = local.authentik_cm_issuer
  authentik_namespace = var.authentik_namespace
  authentik_name = var.authentik_name
  authentik_fqdn = var.authentik_fqdn

  authentik_log_level = var.authentik_log_level
  authentik_secret = random_password.authentik_secret.result
  authentik_bootstrap_mail = var.authentik_bootstrap_mail
  authentik_bootstrap_pass = random_password.authentik_bootstrap_pass.result
  authentik_bootstrap_token = random_password.authentik_bootstrap_token.result
  authentik_blueprints_override_name = var.authentik_blueprints_override_name

  postgres_host = local.authentik_db_host
  postgres_port = var.authentik_db_port
  authentik_db_name = var.authentik_db_name
  authentik_db_user = var.authentik_db_user
  authentik_db_pass = local.authentik_db_pass

  redis_host = local.authentik_redis_host
  redis_pass = local.authentik_redis_pass

  authentik_mail_host = var.authentik_mail_host
  authentik_mail_port = var.authentik_mail_port
  authentik_mail_use_ssl = var.authentik_mail_use_ssl
  authentik_mail_use_tls = var.authentik_mail_use_tls
  authentik_mail_username = var.authentik_mail_username
  authentik_mail_password = var.authentik_mail_password
  authentik_mail_from = var.authentik_mail_from
}

provider "authentik" {
  url   = "https://${var.authentik_fqdn}${var.authentik_path}"
  token = random_password.authentik_bootstrap_token.result
}

module "authentik-config" {
  source = "./modules/authentik-config"

  count = var.configure_authentik == true ? 1 : 0

  depends_on = [ module.authentik-deployment ]

  # Authentik Accessibility configuration
  authentik_token = random_password.authentik_bootstrap_token.result
  authentik_domain = var.authentik_fqdn
  authentik_port = null
  authentik_ssl = true
  authentik_path = var.authentik_path

  # JHaaS Accessibility configuration
  jhaas_domain = var.portal_fqdn
  jhaas_port = null
  jhaas_ssl = true
  jhaas_path = var.jhaas_path

  # JHaaS OIDC configuration
  authentik_jhaas_client_id = var.authentik_jhaas_client_id
  authentik_jhaas_client_secret = random_password.jhaas_client_secret.result
  authentik_provider_redirect_uri = var.authentik_provider_redirect_uri

  # Flows configuration
  authentik_jhaas_login_flow = var.authentik_jhaas_login_flow
  authentik_flow_background = var.authentik_flow_background
  authentik_tos_url = var.authentik_tos_url
  authentik_jhaas_login_redirect = var.authentik_jhaas_login_redirect
  authentik_jhaas_verify_redirect = var.authentik_jhaas_verify_redirect
  authentik_jhaas_launch_url = var.authentik_jhaas_launch_url

  # Branding configuration
  authentik_jhaas_slogan = var.authentik_jhaas_slogan
  authentik_branding_title = var.authentik_branding_title
  authentik_branding_favicon = var.authentik_branding_favicon
  authentik_branding_logo = var.authentik_branding_logo
  authentik_branding_publisher = var.authentik_branding_publisher

  # Mail Templating
  authentik_email_subject_enrollment = var.authentik_email_subject_enrollment
  authentik_email_template_enrollment = var.authentik_email_template_enrollment
  authentik_email_subject_recovery = var.authentik_email_subject_recovery
  authentik_email_template_recovery = var.authentik_email_template_recovery
}

output "authentik_token" {
  value = random_password.authentik_bootstrap_token.result
  sensitive = true
}

output "authentik_password" {
  value = random_password.authentik_bootstrap_pass.result
  sensitive = true
}

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

module "jhaas-portal" {
  source = "./modules/jhaas-portal"

  kubeconfig = local.jhaas_kubeconfig
  cm_issuer = local.jhaas_cm_issuer

  jhaas_helm_registry_host = var.jhaas_helm_registry_host
  jhaas_helm_registry_user = var.jhaas_helm_registry_user
  jhaas_helm_registry_pass = var.jhaas_helm_registry_pass
  jhaas_image_credentials_registry = var.jhaas_image_credentials_registry
  jhaas_image_credentials_user = var.jhaas_image_credentials_user
  jhaas_image_credentials_pass = var.jhaas_image_credentials_pass

  deploy_jhaas = var.deploy_jhaas
  jhaas_name = "jhaas-portal"
  jhaas_namespace = "jhaas-portal"
  jhaas_portal_fqdn = var.portal_fqdn

  jhaas_backend_jh_domain = var.jupyterhubs_base_fqdn
  jhaas_k8s_tf_image = var.jhaas_k8s_tf_image
  jhaas_frontend_url = local.portal_url
  jhaas_session_cookie_secret = "[${random_password.jhaas_session_secret_1.result}, ${random_password.jhaas_session_secret_2.result}]"
  jhaas_redis_url = "redis://default:${local.jhaas_redis_pass}@${local.jhaas_redis_url}/0"
  jhaas_redis_pass = null

  jhaas_authentik_url = "https://${var.authentik_fqdn}"
  jhaas_authentik_api_endpoint = local.authentik_api_url
  jhaas_authentik_api_secret = random_password.authentik_bootstrap_token.result
  jhaas_authentik_jupyter_hub_group = var.jhaas_authentik_jupyter_hub_group
  jhaas_authentik_authentication_flow = var.jhaas_authentik_authentication_flow
  jhaas_authentik_authorization_flow = var.jhaas_authentik_authorization_flow
  jhaas_authentik_icon = var.jhaas_authentik_icon

  jhaas_db_host = local.jhaas_db_host
  jhaas_db_port = var.jhaas_db_port
  jhaas_db_name = var.jhaas_db_name
  jhaas_db_user = var.jhaas_db_user
  jhaas_db_pass = local.jhaas_db_pass

  # Mail (omitted for now)

  jhaas_s3_host = local.jhaas_s3_host
  jhaas_s3_port = var.jhaas_s3_port
  jhaas_s3_ssl = var.jhaas_s3_ssl
  jhaas_s3_access_key = local.jhaas_s3_access_key
  jhaas_s3_secret_key = local.jhaas_s3_secret_key
  jhaas_s3_api = var.jhaas_s3_api
  jhaas_s3_bucket_tf_state = var.jhaas_s3_bucket_tf_state
  jhaas_s3_bucket_jh_specs = var.jhaas_s3_bucket_jh_specs

  jhaas_oidc_endpoint = "${local.authentik_url}application/o/portal"
  jhaas_oidc_callback_url = "${local.portal_url}api/auth/oidc/cb"
  jhaas_oidc_client_id = var.authentik_jhaas_client_id
  jhaas_oidc_client_secret = random_password.jhaas_client_secret.result
}
