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
  authentik_tls_secret_name = "${var.authentik_name}-tls-secret"
}

resource "helm_release" "authentik" {
  name       = var.authentik_name

  repository = "https://charts.goauthentik.io"
  chart      = "authentik"
  # version    = "2023.8.1"

  create_namespace = true
  namespace = var.authentik_namespace

  values = [yamlencode(
    {
      authentik = {
        secret_key = var.authentik_secret,
        error_reporting = {
          enabled = false
        },
        log_level = var.authentik_log_level,
        postgresql = {
          host = var.postgres_host,
          port = var.postgres_port
          name = var.authentik_db_name,
          user = var.authentik_db_user,
          password = var.authentik_db_pass,
        },
        redis = {
          host = var.redis_host,
          password = var.redis_pass
        },
        email = {
          from = var.authentik_mail_from,
          host = var.authentik_mail_host,
          password = var.authentik_mail_password,
          port = var.authentik_mail_port,
          use_ssl = var.authentik_mail_use_ssl,
          use_tls = var.authentik_mail_use_tls,
          username = var.authentik_mail_username
        }
      },
      postgresql = {
        enabled = false
      },
      redis = {
        enabled = false
      },
      ingress = {
        annotations = {
          "kubernetes.io/tls-acme" = "true",
          "cert-manager.io/cluster-issuer" = var.cm_issuer
        },
        enabled = true,
        env = {
          AUTHENTIK_BOOTSTRAP_EMAIL = var.authentik_bootstrap_mail,
          AUTHENTIK_BOOTSTRAP_PASSWORD = var.authentik_bootstrap_pass,
          AUTHENTIK_BOOTSTRAP_TOKEN = var.authentik_bootstrap_token,
          AUTHENTIK_REDIS__DB = 1
        },
        hosts = [
          {
            host = var.authentik_fqdn,
            paths = [
              {
                path = "/",
                pathType = "Prefix"
              }
            ]
          }
        ],
        ingressClassName = "nginx",
        tls = [
          {
            hosts = [var.authentik_fqdn],
            secretName: local.authentik_tls_secret_name
          }
        ]
      },
      volumeMounts = [
        {
          name = var.authentik_blueprints_override_name,
          mountPath = "/blueprints/default"
        }
      ],
      volumes = [
        {
          name = var.authentik_blueprints_override_name,
          emptyDir = {}
        }
      ]
    }
  )]
}

output "authentik_bootstrap_pass" {
  value = var.authentik_bootstrap_pass
}
