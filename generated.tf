provider "random" {}

#################
# AUTHENTIK
#################

# Create random secret key for authentik
resource "random_password" "authentik_secret" {
  length           = 50
  special          = false
}

# Create random api token for authentik akadmin
resource "random_password" "authentik_bootstrap_token" {
  length           = 60
  special          = false
}

# Create random password for authentik akadmin
resource "random_password" "authentik_bootstrap_pass" {
  length           = 32
  special          = false
}

#################
# OIDC
#################

# Create random secret key for jhaas OIDC client
resource "random_password" "jhaas_client_secret" {
  length           = 50
  special          = false
}

##################
# POSTGRES
##################

# Create random password for jhaas_db_user
resource "random_password" "jhaas_db_pass" {
  length           = 32
  special          = false
}

# Create random password for authentik_db_user
resource "random_password" "authentik_db_pass" {
  length           = 32
  special          = false
}

##################
# REDIS
##################

# Create random password for redis
resource "random_password" "redis_pass" {
  length           = 32
  special          = false
}

###############
# MINIO
###############

# Create random user for minio
resource "random_pet" "minio_user" {
  # length is in words
  length           = 1
}

# Create random password for minio
resource "random_password" "minio_pass" {
  length           = 32
  special          = false
}

###############
# JHaaS
###############

# Create a random session cookie secret
resource "random_password" "jhaas_session_secret_1" {
  length = 32
  special = false
}

# Create a random session cookie secret
resource "random_password" "jhaas_session_secret_2" {
  length = 32
  special = false
}
