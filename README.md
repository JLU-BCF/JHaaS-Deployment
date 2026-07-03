# Archiving note

JHaaS is being further developed under the name Kallysto; for this reason, the JHaaS repository is being archived.

You can find the Kallysto resources here: [https://github.com/kallysto-io](https://github.com/kallysto-io)

---

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
