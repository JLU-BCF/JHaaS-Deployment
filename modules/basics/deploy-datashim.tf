# deploy datashim helm chart
## also creates namespace
resource "helm_release" "datashim" {
  count = var.deploy_datashim == true ? 1 : 0

  name            = var.datashim_name
  atomic          = true
  cleanup_on_fail = true

  repository = "https://datashim-io.github.io/datashim"
  chart      = "datashim-charts"
  version    = var.chart_datashim_version

  create_namespace = true
  namespace        = var.datashim_namespace

  values = [yamlencode(
    {
      global = {
        baseRepo = "quay.io/datashim-io",
        sidecars = {
          baseRepo = "registry.k8s.io/sig-storage",
          images = {
            externalAttacher = {
              image = "csi-attacher",
              tag   = "v4.7.0"
            },
            nodeDriverRegistrar = {
              image = "csi-node-driver-registrar",
              tag   = "v2.12.0"
            },
            externalProvisioner = {
              image = "csi-provisioner",
              tag   = "v5.1.0"
            }
          }
        }
      },
      csi-nfs-chart = {
        enabled = false
      },
      csi-s3-chart = {
        enabled = true,
        csis3 = {
          image = "csi-s3",
          tag   = "latest"
        }
      },
      csi-h3-chart = {
        enabled = false
      },
      dataset-operator-chart = {
        generatekeys = {
          image = "generate-keys",
          tag   = "latest"
        },
        datasetoperator = {
          image = "dataset-operator",
          tag   = "latest"
        }
      }
    }
  )]
}

# Deploy s3 data secret for use with datashim
resource "kubernetes_secret" "jhaas-s3-data-conf" {
  depends_on = [helm_release.datashim]

  metadata {
    name      = var.jhaas_s3_data_secret_name
    namespace = var.datashim_namespace
  }

  data = {
    host       = var.jhaas_s3_data_host
    port       = var.jhaas_s3_data_port
    ssl        = var.jhaas_s3_data_ssl
    access_key = var.jhaas_s3_data_access_key
    secret_key = var.jhaas_s3_data_secret_key
  }

  type = "Opaque"
}
