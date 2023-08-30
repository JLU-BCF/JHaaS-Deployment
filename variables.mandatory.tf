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
  description = "FQDN for authentik"
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
