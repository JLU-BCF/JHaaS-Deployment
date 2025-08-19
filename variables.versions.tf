###################
# Chart Versions
###################

# Basics
variable "chart_certmanager_version" {
  description = "value"
  default     = null
}
variable "chart_ingress_version" {
  description = "value"
  default     = null
}
variable "chart_minio_version" {
  description = "value"
  default     = null
}
variable "chart_postgres_version" {
  description = "value"
  default     = null
}
variable "chart_redis_version" {
  description = "value"
  default     = null
}
variable "chart_datashim_version" {
  description = "value"
  default     = null
}
variable "chart_nfs_provisioner_version" {
  description = "value"
  default     = null
}

# Authentik-Deployment
variable "chart_authentik_version" {
  description = "value"
  default     = null
}

# JHaaS
variable "chart_jhaas_version" {
  description = "value"
  default     = null
}

variable "chart_jupyterhub_version" {
  description = "value"
  # default must not be null as this variable will not be used
  # within this tf config but it will be passed through helm!
  default = ""
}
