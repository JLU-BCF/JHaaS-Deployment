variable "kubeconfig" {
  description = "Kubernetes configuration file to use"
  default = "~/.kube/config"
}

variable "deploy_jhaas" {
  description = "value"
  default = true
}

variable "jhaas_name" {
  description = "value"
  default = "jhaas-portal"
}

variable "jhaas_namespace" {
  description = "value"
  default = "jhaas-portal"
}
