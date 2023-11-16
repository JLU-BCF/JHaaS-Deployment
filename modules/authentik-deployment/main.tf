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

resource "kubernetes_namespace" "authentik" {

  count = var.deploy_authentik && var.create_authentik_namespace ? 1 : 0

  metadata {
    name = var.authentik_namespace
  }
}

resource "kubernetes_secret" "bootstrap_data" {

  count      = var.deploy_authentik == true ? 1 : 0
  depends_on = [kubernetes_namespace.authentik]

  metadata {
    name      = "authentik-bootstrap-data"
    namespace = var.authentik_namespace
  }

  data = {
    AUTHENTIK_BOOTSTRAP_EMAIL    = var.authentik_bootstrap_mail
    AUTHENTIK_BOOTSTRAP_PASSWORD = var.authentik_bootstrap_pass
    AUTHENTIK_BOOTSTRAP_TOKEN    = var.authentik_bootstrap_token
  }
}

resource "kubernetes_config_map" "templates" {

  count      = var.deploy_authentik == true ? 1 : 0
  depends_on = [kubernetes_namespace.authentik]

  metadata {
    name      = "authentik-templates"
    namespace = var.authentik_namespace
  }

  data = {
    for template in fileset("${path.module}/templates", "*.html") :
    template => file(format("%s/%s", "${path.module}/templates", template))
  }
}

resource "kubernetes_config_map" "assets" {

  count      = var.deploy_authentik == true ? 1 : 0
  depends_on = [kubernetes_namespace.authentik]

  metadata {
    name      = "authentik-assets"
    namespace = var.authentik_namespace
  }

  binary_data = {
    for asset in fileset("${path.module}/assets", "*") :
    asset => filebase64(format("%s/%s", "${path.module}/assets", asset))
  }
}

resource "helm_release" "authentik" {
  name  = var.authentik_name
  count = var.deploy_authentik == true ? 1 : 0

  depends_on = [
    kubernetes_secret.bootstrap_data,
    kubernetes_config_map.templates,
    kubernetes_config_map.assets
  ]

  repository = "https://charts.goauthentik.io"
  chart      = "authentik"
  version    = var.chart_authentik_version

  create_namespace = true
  namespace        = var.authentik_namespace

  values = [yamlencode(
    {
      authentik = {
        secret_key = var.authentik_secret,
        error_reporting = {
          enabled = false
        },
        log_level = var.authentik_log_level,
        postgresql = {
          host     = var.postgres_host,
          port     = var.postgres_port
          name     = var.authentik_db_name,
          user     = var.authentik_db_user,
          password = var.authentik_db_pass,
        },
        redis = {
          host     = var.redis_host,
          password = var.redis_pass
        },
        email = {
          from     = var.authentik_mail_from,
          host     = var.authentik_mail_host,
          password = var.authentik_mail_password,
          port     = var.authentik_mail_port,
          use_ssl  = var.authentik_mail_use_ssl,
          use_tls  = var.authentik_mail_use_tls,
          username = var.authentik_mail_username
        }
      },
      env = {
        AUTHENTIK_REDIS__DB = 1,
        AUTHENTIK_FOOTER_LINKS = jsonencode([
          {
            name = "Login",
            href = "/if/flow/auth/"
          },
          {
            name = "Password Reset",
            href = "/if/flow/password-recovery/"
          },
          {
            name = "MFA Reset",
            href = "/if/flow/mfa-recovery/"
          }
        ])
      },
      envFrom = [
        {
          secretRef = {
            name = "authentik-bootstrap-data"
          }
        }
      ],
      postgresql = {
        enabled = false
      },
      redis = {
        enabled = false
      },
      ingress = {
        annotations = {
          "kubernetes.io/tls-acme"         = "true",
          "cert-manager.io/cluster-issuer" = var.cm_issuer
        },
        enabled = true,
        hosts = [
          {
            host = var.authentik_fqdn,
            paths = [
              {
                path     = "/",
                pathType = "Prefix"
              }
            ]
          }
        ],
        ingressClassName = "nginx",
        tls = [
          {
            hosts = [var.authentik_fqdn],
            secretName : local.authentik_tls_secret_name
          }
        ]
      },
      volumeMounts = [
        {
          name      = var.authentik_blueprints_override_name,
          mountPath = "/blueprints/default"
        },
        {
          name      = "authentik-email-templates",
          mountPath = "/templates"
        },
        {
          name      = "authentik-assets",
          mountPath = "/web/dist/assets/custom"
        }
      ],
      volumes = [
        {
          name     = var.authentik_blueprints_override_name,
          emptyDir = {}
        },
        {
          name = "authentik-email-templates",
          configMap = {
            name = "authentik-templates"
          }
        },
        {
          name = "authentik-assets",
          configMap = {
            name = "authentik-assets"
          }
        }
      ]
    }
  )]
}
