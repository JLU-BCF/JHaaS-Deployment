# deploy nfs provisioner helm chart

resource "helm_release" "nfs_provisioner" {
  count = var.deploy_nfs_provisioner ? 1 : 0

  name            = var.nfs_provisioner_name
  atomic          = true
  cleanup_on_fail = true

  repository = "https://kubernetes-sigs.github.io/nfs-ganesha-server-and-external-provisioner"
  chart      = "nfs-server-provisioner"
  version    = var.chart_nfs_provisioner_version

  values = [yamlencode(
    {
      persistence = {
        enabled = true,
        size    = var.nfs_storage_size
      },
      storageClass = {
        create               = true,
        defaultClass         = false,
        name                 = var.nfs_storageclass_name,
        allowVolumeExpansion = true
      }
    }
  )]
}
