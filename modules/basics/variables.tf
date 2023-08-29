variable "kubeconfig" {
    description = "Kubernetes configuration file to use"
}

variable "issuer_email" {
    description = "email address to use for certmanager issuer"
}

variable "ingress_namespace" {
    description = "Namespace for nginx ingress"
    default = "nginx-ingress"
}

variable "cm_namespace" {
    description = "Namespace to be used for cert-manager"
    default = "cert-manager"
}

variable "cm_issuer" {
    description = "Name for the default cert-manager cluster issuer"
    default = "cluster-issuer"
}
