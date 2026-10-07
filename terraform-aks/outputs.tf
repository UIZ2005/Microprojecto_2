output "conectar_cluster" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.rg_aks.name} --name ${azurerm_kubernetes_cluster.aks.name} --overwrite-existing"
}

output "ver_ip_ingress" {
  value = "kubectl get ingress -n microapp"
}
