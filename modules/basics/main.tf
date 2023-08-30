provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig
}

provider "kubectl" {
  config_path = var.kubeconfig
}

locals {
  cm_issuer_secret_name = "${var.cm_issuer}-private-key"
}


# deploy cert manager and create an issuer
## also creates namespace
module "cert_manager" {
  count = var.deploy_cert_manager == true ? 1 : 0

  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = var.cm_issuer_email
  cluster_issuer_name                    = var.cm_issuer
  cluster_issuer_private_key_secret_name = local.cm_issuer_secret_name

  create_namespace = true
  namespace_name = var.cm_namespace
}

# deploy nginx ingress controller
## also creates namespace
module "nginx-ingress-controller" {
  count = var.deploy_nginx_ingress_controller == true ? 1 : 0

  source  = "terraform-iaac/nginx-controller/helm"

  controller_kind = "Deployment"
  define_nodePorts = false

  additional_set = []

  create_namespace = true
  namespace = var.ingress_namespace
}

# deploy postgres
## also creates namespace
resource "helm_release" "postgres" {
  count = var.deploy_postgres == true ? 1 : 0

  name       = var.postgres_name

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  # version    = "2023.8.1"

  create_namespace = true
  namespace = var.postgres_namespace

  values = [yamlencode(
    {
      fullnameOverride = var.postgres_name,
      auth = {
        enablePostgresUser = false
      },
      primary = {
        initdb = {
          user = "postgres",
          scripts = {
            seed = <<-SEED_DB
              #!/bin/bash

              set -e
              set -u

              psql -v ON_ERROR_STOP=1 <<-EOSQL
                    CREATE USER "${var.jhaas_db_user}" WITH password '${var.jhaas_db_pass}';
                    CREATE DATABASE "${var.jhaas_db_name}";
                    ALTER DATABASE "${var.jhaas_db_name}" OWNER TO "${var.jhaas_db_user}"
              EOSQL

              psql -v ON_ERROR_STOP=1 <<-EOSQL
                    CREATE USER "${var.authentik_db_user}" WITH password '${var.authentik_db_pass}';
                    CREATE DATABASE "${var.authentik_db_name}";
                    ALTER DATABASE "${var.authentik_db_name}" OWNER TO "${var.authentik_db_user}"
              EOSQL
            SEED_DB
          }
        }
      }
    }
  )]
}

# deploy redis
## also creates namespace
resource "helm_release" "redis" {
  count = var.deploy_redis == true ? 1 : 0

  name       = var.redis_name

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  # version    = "2023.8.1"

  create_namespace = true
  namespace = var.redis_namespace

  values = [yamlencode(
    {
      fullnameOverride = var.redis_name,
      architecture = "standalone",
      auth = {
        enabled = true,
        password = var.redis_pass
      },
      sentinel = {
        enabled = false
      }
    }
  )]
}

# deploy minio
## also creates namespace
resource "helm_release" "minio" {
  count = var.deploy_minio == true ? 1 : 0

  name       = var.minio_name

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "minio"
  # version    = "2023.8.1"

  create_namespace = true
  namespace = var.minio_namespace

  values = [yamlencode(
    {
      fullnameOverride = var.minio_name,
      auth = {
        rootUser = var.minio_user,
        rootPassword = var.minio_pass
      },
      defaultBuckets = var.minio_buckets
    }
  )]
}
