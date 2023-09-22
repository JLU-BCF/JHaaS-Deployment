###################
# Chart Versions
###################

# Basics
variable "chart_certmanager_version" {
  description = "value"
  default     = "v1.13.0"
}
variable "chart_ingress_version" {
  description = "value"
  default     = "4.7.2"
}
variable "chart_minio_version" {
  description = "value"
  default     = "12.8.5"
}
variable "chart_postgres_version" {
  description = "value"
  default     = "12.11.2"
}
variable "chart_redis_version" {
  description = "value"
  default     = "18.0.4"
}

# Authentik-Deployment
variable "chart_authentik_version" {
  description = "value"
  default     = "2023.8.3"
}

# JHaaS
variable "chart_jhaas_version" {
  description = "value"
  default     = "0.1.0"
}

# JHaaS User Docs
variable "chart_jhaas_user_docs_version" {
  description = "value"
  default = "0.1.0"
}
