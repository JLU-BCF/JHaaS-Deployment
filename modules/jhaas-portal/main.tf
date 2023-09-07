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

  repository = "https://git.computational.bio.uni-giessen.de/jhaas/portal-helm-chart"
  chart      = "jhaas-portal"
  # version    = "2023.8.1"

  create_namespace = true
  namespace = var.jhaas_namespace

  values = [yamlencode(
    {
      jhaas = {
        domain = "",
        issuer = "",
        icon = ""
      },
      imageCredentials = {
        registry = "harbor.computational.bio.uni-giessen.de",
        username = "",
        password = ""
      },
      backend = {

      },
      frontend = {

      },
      postgres = {
        enabled = false
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
