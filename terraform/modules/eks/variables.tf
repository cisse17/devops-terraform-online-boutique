# ========================================
# VARIABLES MODULE EKS
# ========================================

variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
}

variable "kubernetes_version" {
  description = "Version de Kubernetes"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "Liste des IDs des subnets privés"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Liste des IDs des subnets publics"
  type        = list(string)
}

variable "node_desired_size" {
  description = "Nombre désiré de nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Nombre minimum de nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Nombre maximum de nodes"
  type        = number
  default     = 5
}

variable "node_instance_types" {
  description = "Types d'instances pour les nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_disk_size" {
  description = "Taille du disque des nodes en GB"
  type        = number
  default     = 20
}

variable "log_retention_days" {
  description = "Durée de rétention des logs CloudWatch en jours"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags à appliquer à toutes les ressources"
  type        = map(string)
  default     = {}
}