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

resource "helm_release" "jhaas" {
  name       = var.jhaas_name
  count      = var.deploy_jhaas == true ? 1 : 0

  repository = "oci://harbor.computational.bio.uni-giessen.de/jhaas"
  chart      = "jhaas-portal"
  # version    = "2023.8.1"

  create_namespace = true
  namespace = var.jhaas_namespace

  values = [yamlencode(
    {
      jhaas = {
        domain = var.jhaas_portal_fqdn,
        issuer = var.cm_issuer,
        icon = ""
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
          K8S_TF_NS = ""
          NODE_ENV = "production"
          PORT = "8000"
          FRONTEND_URL = ""
          SESSION_COOKIE_SECRET = var.jhaas_session_cookie_secret
          SESSION_STORAGE = "redis"
          SESSION_STORAGE_URL = var.jhaas_redis_url
        }
      },
      frontend = {
        image = {
          registry = "harbor.computational.bio.uni-giessen.de"
          repository = "jhaas/jhaas-frontend"
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
          POSTGRES_HOST = ""
          POSTGRES_PORT = ""
          POSTGRES_DB = ""
          POSTGRES_USER = ""
          POSTGRES_PASSWORD = ""
        }
      },
      redis = {
        enabled = false
      },
      ingress = {
        enabled = true,
        host = "",
        tls = {
          enabled = true,
          issuer = "",
          secretName = ""
        }
      },
      mail = {
        host = "",
        port = "",
        secure = false,
        from = "",
        from_name = "",
        copy_addresses = "[]"
      },
      s3 = {
        host = "",
        port = 80,
        ssl = false,
        access_key = "",
        secret_key = "",
        api = "S3v2",
        buckets = {
          tf_state = "tf-state",
          jh_specs = "jh_specs"
        }
      },
      oidc = {
        endpoint = "",
        callback_url = "",
        client_id = "",
        client_secret = ""
      }
      authentik = {
        url = "",
        api_endpoint = "",
        api_secret = "",
        jupyter_hub_group = "",
        authentication_flow = "",
        authorization_flow = ""
      }
    }
  )]
}
