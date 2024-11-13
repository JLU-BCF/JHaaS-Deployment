# deploy postgres
## also creates namespace
resource "helm_release" "postgres" {
  count = var.deploy_postgres == true ? 1 : 0

  name       = var.postgres_name
  atomic = true
  cleanup_on_fail = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = var.chart_postgres_version

  create_namespace = true
  namespace = var.postgres_namespace

  values = [yamlencode(
    {
      fullnameOverride = var.postgres_name,
      auth = {
        enablePostgresUser = false
      },
      primary = {
        initdb = {
          user = "postgres",
          scripts = {
            "seed.sh" = <<-SEED_DB
              #!/bin/bash

              set -e
              set -u

              psql -v ON_ERROR_STOP=1 <<-EOSQL
                    CREATE USER "${var.jhaas_db_user}" WITH password '${var.jhaas_db_pass}';
                    CREATE DATABASE "${var.jhaas_db_name}";
                    ALTER DATABASE "${var.jhaas_db_name}" OWNER TO "${var.jhaas_db_user}"
              EOSQL

              psql -v ON_ERROR_STOP=1 <<-EOSQL
                    CREATE USER "${var.authentik_db_user}" WITH password '${var.authentik_db_pass}';
                    CREATE DATABASE "${var.authentik_db_name}";
                    ALTER DATABASE "${var.authentik_db_name}" OWNER TO "${var.authentik_db_user}"
              EOSQL
            SEED_DB
          }
        },
        persistence = {
          size = 8Gi
        },
        resources = {
          requests = {
            cpu = 100m,
            memory = 256Mi
          },
          limits = {
            cpu = 2,
            memory = 1024Mi
          }
        }
      }
    }
  )]
}
