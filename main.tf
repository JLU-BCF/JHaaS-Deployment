module "basics" {
  source = "./modules/basics"

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
  minio_pass      = random_password.minio_pass
  minio_buckets   = var.minio_buckets
}

module "authentik-deploy" {
  source = "./modules/authentik-deploy"

  # depends_on = [
  #   random_password.authentik_secret,
  #   random_password.authentik_token,
  #   random_password.authentik_password,
  #   random_pet.db_user,
  #   random_password.db_pass
  # ]

  kubeconfig_path = var.kubeconfig_path
  k8s_namespace = var.k8s_namespace
  release_name = var.release_name

  authentik_version = var.authentik_version
  authentik_hostname = var.authentik_hostname
  authentik_secret = random_password.authentik_secret.result
  authentik_token = random_password.authentik_token.result
  authentik_password = random_password.authentik_password.result
  authentik_email = var.authentik_email

  postgresql_enabled = var.postgresql_enabled
  postgres_name = "authentik"
  postgres_user = random_pet.db_user.id
  postgres_pass = random_password.db_pass.result

  use_tls = var.use_tls
  ingress_use_tls_acme = var.ingress_use_tls_acme
  ingress_tls_secret_name = var.ingress_tls_secret_name
  ingress_cert_manager_issuer = var.ingress_cert_manager_issuer

}
