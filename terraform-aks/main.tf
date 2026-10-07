resource "azurerm_resource_group" "rg_aks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg_aks.location
  resource_group_name = azurerm_resource_group.rg_aks.name
  dns_prefix          = "aksparcial2"
  sku_tier            = "Free"

  
  default_node_pool {
    name            = "nodepool1"
    node_count      = var.node_count
    vm_size         = var.node_size
    os_disk_size_gb = 30
  }

  
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
  }

  
  web_app_routing {
    dns_zone_ids = []
  }
}


resource "terraform_data" "desplegar_app" {
  depends_on = [azurerm_kubernetes_cluster.aks]

  
  triggers_replace = concat(
    [azurerm_kubernetes_cluster.aks.id],
    [for f in sort(fileset("${path.module}/../k8s", "**")) :
      filemd5("${path.module}/../k8s/${f}")]
  )

  provisioner "local-exec" {
    command = <<-EOT
      az aks get-credentials --resource-group ${azurerm_resource_group.rg_aks.name} --name ${azurerm_kubernetes_cluster.aks.name} --overwrite-existing
      kubectl apply -k ${path.module}/../k8s
    EOT
  }
}
