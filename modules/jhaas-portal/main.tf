provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
  registry {
    url = var.jhaas_helm_registry_host
    username = var.jhaas_helm_registry_user
    password = var.jhaas_helm_registry_pass
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig
}

provider "kubectl" {
  config_path = var.kubeconfig
}

locals {
  jhaas_tls_secret_name = "${var.jhaas_name}-tls-secret"
}

resource "kubernetes_namespace" "jhaas" {

  count      = var.deploy_jhaas && var.create_jhaas_namespace ? 1 : 0

  metadata {
    name = var.jhaas_namespace
  }
}

resource "kubernetes_secret" "jupyter_cluster_kubeconfig" {
  count      = var.deploy_jhaas == true ? 1 : 0

  depends_on = [ kubernetes_namespace.jhaas ]

  metadata {
    name = "sec-${var.jhaas_name}-cloud-kubeconfig"
    namespace = var.jhaas_namespace
    labels = {
      "${var.jhaas_name}.secret" = "${var.jhaas_name}-cloud-kubeconfig"
    }
  }
  data = {
    "kubeconfig.secret" = file(var.kubeconfig_hubs)
  }
}

resource "helm_release" "jhaas" {
  name       = var.jhaas_name
  count      = var.deploy_jhaas == true ? 1 : 0

  repository = "oci://harbor.computational.bio.uni-giessen.de/jhaas"
  chart      = "jhaas-portal"
  version    = var.chart_jhaas_version

  create_namespace = true
  namespace = var.jhaas_namespace

  values = [yamlencode(
    {
      jhaas = {
        domain = var.jhaas_portal_fqdn,
        issuer = var.cm_issuer_hubs,
        icon = var.jhaas_authentik_icon
      },
      imageCredentials = {
        registry = var.jhaas_image_credentials_registry,
        username = var.jhaas_image_credentials_user,
        password = var.jhaas_image_credentials_pass
      },
      backend = {
        image = {
          registry = "harbor.computational.bio.uni-giessen.de"
          repository = "jhaas/portal-backend"
          tag = "master"
          pullPolicy = "IfNotPresent"
        }
        conf = {
          JH_DOMAIN = var.jhaas_backend_jh_domain
          K8S_TF_IMAGE = var.jhaas_k8s_tf_image
          K8S_TF_IMAGE_PP = "IfNotPresent"
          K8S_TF_NS = var.jhaas_namespace
          NODE_ENV = "production"
          PORT = "8000"
          FRONTEND_URL = "https://${var.jhaas_portal_fqdn}/"
          SESSION_COOKIE_SECRET = var.jhaas_session_cookie_secret
          SESSION_STORAGE = "redis"
          SESSION_STORAGE_URL = var.jhaas_redis_url
        }
      },
      frontend = {
        image = {
          registry = "harbor.computational.bio.uni-giessen.de"
          repository = "jhaas/portal-frontend"
          tag = "master"
          pullPolicy = "IfNotPresent"
        },
        conf = {
          port = "80"
        }
      },
      postgres = {
        enabled = false
        conf = {
          POSTGRES_HOST = var.jhaas_db_host
          POSTGRES_PORT = var.jhaas_db_port
          POSTGRES_DB = var.jhaas_db_name
          POSTGRES_USER = var.jhaas_db_user
          POSTGRES_PASSWORD = var.jhaas_db_pass
        }
      },
      redis = {
        enabled = false
      },
      ingress = {
        enabled = true,
        host = var.jhaas_portal_fqdn,
        tls = {
          enabled = true,
          issuer = var.cm_issuer,
          secretName = local.jhaas_tls_secret_name
        }
      },
      mail = {
        host = var.jhaas_mail_host,
        port = var.jhaas_mail_port,
        secure = var.jhaas_mail_secure,
        from = var.jhaas_mail_from,
        from_name = var.jhaas_mail_from_name,
        copy_addresses = var.jhaas_mail_copy_addresses
      },
      s3 = {
        host = var.jhaas_s3_host,
        port = var.jhaas_s3_port,
        ssl = var.jhaas_s3_ssl,
        access_key = var.jhaas_s3_access_key,
        secret_key = var.jhaas_s3_secret_key,
        api = var.jhaas_s3_api,
        buckets = {
          tf_state = var.jhaas_s3_bucket_tf_state,
          jh_specs = var.jhaas_s3_bucket_jh_specs
        }
      },
      oidc = {
        endpoint = var.jhaas_oidc_endpoint,
        callback_url = var.jhaas_oidc_callback_url,
        client_id = var.jhaas_oidc_client_id,
        client_secret = var.jhaas_oidc_client_secret
      }
      authentik = {
        url = var.jhaas_authentik_url,
        api_endpoint = var.jhaas_authentik_api_endpoint,
        api_secret = var.jhaas_authentik_api_secret,
        jupyter_hub_group = var.jhaas_authentik_jupyter_hub_group,
        authentication_flow = var.jhaas_authentik_authentication_flow,
        authorization_flow = var.jhaas_authentik_authorization_flow
      }
    }
  )]
}
