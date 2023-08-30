provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

provider "kubernetes" {
  config_path    = var.kubeconfig
}

# Create k8s namespace to deploy authentik in
resource "kubernetes_namespace" "authentik" {
  metadata {
    name = "authentik"
  }
}

resource "helm_release" "authentik" {
  name       = "authentik"

  repository = "https://charts.goauthentik.io"
  chart      = "authentik"
  version    = "2023.8.1"

  values = [yamlencode(
    {
      authentik = {
        secret_key = var.authentik_secret,
        error_reporting = {
          enabled = false
        },
        log_level = "info",
        postgresql = {
          host = "authentik",
          name = "authentik",
          password = "test",
          port = 5432
          user = "authentik",
        },
        redis = {
          host = "redis",
          password = ""
        },
        email = {
          from = "",
          host = "",
          password = "",
          port = 587,
          use_ssl = false,
          use_tls = false,
          username = ""
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
          "cert-manager.io/cluster-issuer" = "cluster-issuer"
        },
        enabled = true,
        hosts = [
          {
            host = "authentik.jhaas.gi.denbi.de",
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
            hosts = ["authentik.jhaas.gi.denbi.de"],
            secretName: "authentik-tls-secret"
          }
        ]
      },
      volumeMounts = [
        {
          name = "blueprints-default-override",
          mountPath = "/blueprints/default"
        }
      ],
      volumes = [
        {
          name = "blueprints-default-override",
          emptyDir = {}
        }
      ]

    ######################

    }
  )]

}
