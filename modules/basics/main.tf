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
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = var.issuer_email
  cluster_issuer_name                    = var.cm_issuer
  cluster_issuer_private_key_secret_name = local.cm_issuer_secret_name

  create_namespace = true
  namespace_name = var.cm_namespace
}

# deploy nginx ingress controller
## also creates namespace
module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"

  controller_kind = "Deployment"
  define_nodePorts = false

  additional_set = []

  create_namespace = true
  namespace = var.ingress_namespace
}
