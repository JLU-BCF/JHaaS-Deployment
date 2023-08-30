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
