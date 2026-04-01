# ========================================
# VARIABLES ENVIRONNEMENT DEV
# ========================================

variable "aws_region" {
  description = "Région AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Online Boutique Black Friday Survival"
  type        = string
  default     = "black-friday-bassirou"
}

variable "environment" {
  description = "Environnement developpement"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Propriétaire du projet"
  type        = string
  default     = "hetic-student"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# EKS Configuration
variable "kubernetes_version" {
  description = "Version de Kubernetes"
  type        = string
  default     = "1.29"
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
  description = "Durée de rétention des logs CloudWatch"
  type        = number
  default     = 7
}




variable "cluster_name" {
  description = "Nom du cluster EKS (pour les tags des subnets)"
  type        = string
}

variable "tags" {
  description = "Tags à appliquer à toutes les ressources"
  type        = map(string)
  default     = {}
}