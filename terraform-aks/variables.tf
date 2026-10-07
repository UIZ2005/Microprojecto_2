variable "resource_group_name" {
  description = "Grupo de recursos del clúster"
  type        = string
  default     = "rg-parcial2-aks"
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "mexicocentral"
}

variable "cluster_name" {
  type    = string
  default = "aks-parcial2"
}

variable "node_count" {
  description = "Cantidad de nodos (VMs) del clúster"
  type        = number
  default     = 2
}

variable "node_size" {
  description = "Tamaño de cada nodo"
  type        = string
  default     = "Standard_B2als_v2"
}
