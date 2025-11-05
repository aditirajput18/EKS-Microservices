output "cluster_name" {
  value = module.eks.cluster_id
}

output "kubeconfig_certificate_authority_data" {
  value = module.eks.cluster_ca_certificate
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "auth_ecr_repo" {
  value = aws_ecr_repository.auth.repository_url
}

output "orders_ecr_repo" {
  value = aws_ecr_repository.orders.repository_url
}

output "payments_ecr_repo" {
  value = aws_ecr_repository.payments.repository_url
}
