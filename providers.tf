terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2023.6.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}
