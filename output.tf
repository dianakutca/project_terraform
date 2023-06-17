output "database_endpoint" {
  value = aws_rds_cluster.db_instance.endpoint
}

output "load_balancer_arn" {
  value = aws_alb.application-lb.arn
}

output "aws_alb_dns_name" {
  value = aws_alb.application-lb.dns_name
}

output "database_writer_endpoint" {
  value = aws_rds_cluster_instance.writer_instance[0].endpoint
}

# output "reader_instance" {
#   value = aws_rds_cluster_instance.project_database
# }