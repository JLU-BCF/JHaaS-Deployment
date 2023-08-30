######################
# General
######################
variable "kubeconfig" {
  description = "Kubernetes configuration file to use"
  default = "~/.kube/config"
}

variable "authentik_name" {
  description = "value"
  default = "authentik"
}

variable "authentik_name" {
  description = "value"
  default = "authentik"
}

variable "authentik_fqdn" {
  description = "value"
  default = "authentik.jhaas.gi.denbi.de"
}

######################
# Authentik
######################
variable "authentik_log_level" {
  description = "value"
  default = "info"
}

variable "authentik_secret" {
  description = "The authentik secret to sign cookies and do other stuff"
}

variable "authentik_bootstrap_mail" {
  description = "value"
  default = ""
}

variable "authentik_bootstrap_pass" {
  description = "value"
  default = ""
}

variable "authentik_bootstrap_token" {
  description = "value"
  default = ""
}

variable "authentik_blueprints_override_name" {
  description = "value"
  default = "authentik-blueprints-override"
}

######################
# Database
######################
variable "postgres_host" {
  description = "value"
  default = "postgres.postgres"
}

variable "postgres_port" {
  description = "value"
  default = 5432
}

variable "authentik_db_name" {
  description = "value"
  default = "authentik"
}

variable "authentik_db_user" {
  description = "value"
  default = "authentik"
}

variable "authentik_db_pass" {
  description = "value"
  default = "authentik"
}

######################
# Redis
######################
variable "redis_host" {
  description = "value"
  default = "redis.redis"
}

variable "redis_pass" {
  description = "value"
  default = "redis"
}

######################
# Mail
######################

variable "authentik_mail_host" {
  description = "value"
  default = ""
}

variable "authentik_mail_port" {
  description = "value"
  default =  587
}

variable "authentik_mail_use_ssl" {
  description = "value"
  default = false
}

variable "authentik_mail_use_tls" {
  description = "value"
  default = false
}

variable "authentik_mail_username" {
  description = "value"
  default = ""
}

variable "authentik_mail_password" {
  description = "value"
  default = ""
}

variable "authentik_mail_from" {
  description = "value"
  default = ""
}

######################
# Ingress
######################
variable "cm_issuer" {
  description = "value"
  default = "cluster-issuer"
}
