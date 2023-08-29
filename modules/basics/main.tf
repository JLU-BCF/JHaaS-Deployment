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

# deploy cert manager and create an issuer
## also creates namespace "cert-manager"
module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = var.issuer_email
  cluster_issuer_name                    = "cert-manager-cluster-issuer"
  cluster_issuer_private_key_secret_name = "cert-manager-cluster-issuer-private-key"
}

# deploy nginx ingress controller
## also creates namespace "nginx-ingress"
module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"

  create_namespace = true
  controller_kind = "Deployment"
  namespace = "nginx-ingress"
  define_nodePorts = false

  additional_set = []
}
