resource "aws_route53_record" "www" {
  zone_id = "Z02170421JNU7XEVMBN6G"
  name    = "project.treenetsolution.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_alb.application-lb.dns_name]
}


resource "aws_route53_record" "database_writer_endpoint" {
  zone_id = "Z02170421JNU7XEVMBN6G"
  name    = "writer.treenetsolution.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.writer_instance[0].endpoint]
}