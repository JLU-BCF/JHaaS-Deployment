# deploy redis
## also creates namespace
resource "helm_release" "redis" {
  count = var.deploy_redis == true ? 1 : 0

  name       = var.redis_name
  atomic = true
  cleanup_on_fail = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  # version    = "2023.8.1"

  create_namespace = true
  namespace = var.redis_namespace

  values = [yamlencode(
    {
      fullnameOverride = var.redis_name,
      architecture = "standalone",
      auth = {
        enabled = true,
        password = var.redis_pass
      },
      sentinel = {
        enabled = false
      }
    }
  )]
}
