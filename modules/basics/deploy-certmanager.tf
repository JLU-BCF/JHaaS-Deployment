# deploy cert manager and create an issuer
## also creates namespace
resource "helm_release" "cert_manager" {
  count = var.deploy_cert_manager == true ? 1 : 0

  name   = var.cm_name
  atomic = true
  cleanup_on_fail = true

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  # version    = var.chart_version

  create_namespace = true
  namespace = var.cm_namespace

  values = [yamlencode(
    {
      installCRDs = true
    }
  )]
}

resource "time_sleep" "wait_cm" {
  count = var.deploy_cert_manager == true ? 1 : 0
  create_duration = "60s"

  depends_on = [helm_release.cert_manager]
}

resource "kubectl_manifest" "cluster_issuer" {
  count = var.deploy_cert_manager == true ? 1 : 0
  depends_on = [time_sleep.wait_cm]

  validate_schema = false

  yaml_body = yamlencode(
    {
      apiVersion = "cert-manager.io/v1"
      kind       = "ClusterIssuer"
      metadata = {
        name = var.cm_issuer
      }
      spec = {
        acme = {
          # The ACME server URL
          server         = var.cm_issuer_server
          preferredChain = "ISRG Root X1"
          # Email address used for ACME registration
          email = var.cm_issuer_email
          # Name of a secret used to store the ACME account private key
          privateKeySecretRef = {
            name = local.cm_issuer_secret_name
          }
          # Enable the HTTP-01 challenge provider
          solvers = [
            {
              http01 = {
                ingress = {
                  class = "nginx"
                }
              }
            }
          ]
        }
      }
    }
  )
}
