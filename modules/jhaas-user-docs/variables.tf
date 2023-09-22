variable "jhaas_user_docs_fqdn" {
  description = "value"
}
variable "jhaas_user_docs_cm_issuer" {
  description = "value"
  default = "cluster-issuer"
}
variable "jhaas_user_docs_name" {
  description = "value"
  default = "jhaas-user-docs"
}
variable "jhaas_user_docs_namespace" {
  description = "value"
  default = "jhaas-user-docs"
}
variable "chart_jhaas_user_docs_version" {
  description = "value"
  default = "0.1.0"
}
variable "jhaas_user_docs_image_name" {
  description = "value"
  default = "harbor.computational.bio.uni-giessen.de/jhaas/user:master"
}
