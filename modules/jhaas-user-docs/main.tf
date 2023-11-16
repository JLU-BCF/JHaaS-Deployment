resource "helm_release" "jhaas-user-docs" {
  name            = var.jhaas_user_docs_name
  atomic          = true
  cleanup_on_fail = true

  repository = "oci://harbor.computational.bio.uni-giessen.de/jhaas"
  chart      = "jhaas-user-docs"
  version    = var.chart_jhaas_user_docs_version

  create_namespace = true
  namespace        = var.jhaas_user_docs_namespace

  values = [yamlencode(
    {
      imageCredentials = []
      userDocs = {
        image = {
          name       = var.jhaas_user_docs_image_name
          pullPolicy = "IfNotPresent"
        }
        port = "80"
      }
      ingress = {
        enabled = true
        host    = var.jhaas_user_docs_fqdn
        tls = {
          enabled    = true
          issuer     = var.jhaas_user_docs_cm_issuer
          secretName = false
        }
      }
    }
  )]
}
