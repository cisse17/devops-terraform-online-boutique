# # KMS Key pour chiffrement des secrets
# resource "aws_kms_key" "eks_secrets" {
#   description             = "EKS Secrets Encryption Key"
#   deletion_window_in_days = 7
#   enable_key_rotation     = true

#   tags = merge(
#     var.tags,
#     {
#       Name = "${var.cluster_name}-secrets-key"
#     }
#   )
# }

# resource "aws_kms_alias" "eks_secrets" {
#   name          = "alias/${var.cluster_name}-secrets"
#   target_key_id = aws_kms_key.eks_secrets.key_id
# }