# deploy minio
## also creates namespace
resource "helm_release" "minio" {
  count = var.deploy_minio == true ? 1 : 0

  name       = var.minio_name
  atomic = true
  cleanup_on_fail = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "minio"
  version    = var.chart_minio_version

  create_namespace = true
  namespace = var.minio_namespace

  values = [yamlencode(
    {
      fullnameOverride = var.minio_name,
      auth = {
        rootUser = var.minio_user,
        rootPassword = var.minio_pass
      },
      defaultBuckets = var.minio_buckets,
      persistence = {
        size = "8Gi"
      },
      resources = {
        requests = {
          cpu = "100m",
          memory = "256Mi"
        },
        limits = {
          cpu = "2",
          memory = "1024Mi"
        }
      }
    }
  )]
}
