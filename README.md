# JHaaS Deployment

This repository contains all necessary configurations to deploy JHaaS from scratch.

This includes:

- Basic requirements like Ingress Controller and Cert Manager (via TF Providers)
- Authentik (via Helm Chart)
- Authentik configuration for JHaaS (via TF Modul)
- JHaaS Portal (via Helm Chart)

This requires:

- A kubernetes Cluster for the JHaaS Portal
- A FQDN and a wildcard entry on subdomains under your FQDN
- (Optional) Other kubernetes clusters for Service Deployments