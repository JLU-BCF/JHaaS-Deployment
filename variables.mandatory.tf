###############
# COMMON
###############
variable "kubeconfig" {
  description = "Kubernetes configuration file to use"
}

###############
# AUTHENTIK
###############
variable "authentik_fqdn" {
  description = "value"
  default = "authentik.jhaas.gi.denbi.de"
}

variable "authentik_bootstrap_mail" {
  description = "value"
  default = ""
}

###############
# PORTAL
###############
variable "portal_fqdn" {
  description = "FQDN for the portal"
}

###############
# CERT-MANAGER
###############
variable "cm_issuer_email" {
  description = "E-Mail to be used with cert manager. Mandatory if cert-manager shall be deployed."
  # default = null
}
