output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}

output "rds_writer_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.rds-aurora.cluster_endpoint
}

output "rds_reader_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.rds-aurora.cluster_reader_endpoint
}

output "rds_additional" {
  description = "Additional"
  value       = module.rds-aurora.additional_cluster_endpoints
}

output "cluster_port" {
  description = "The database port"
  value       = module.rds-aurora.cluster_port
}

