# deploy nginx ingress controller
## also creates namespace
resource "helm_release" "application" {
  count = var.deploy_nginx_ingress_controller ? 1 : 0

  name             = var.ingress_name
  atomic           = true
  cleanup_on_fail = true

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.chart_ingress_version

  create_namespace = true
  namespace        = var.ingress_namespace

  values = [yamlencode(
    {}
  )]
}
