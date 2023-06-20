resource "aws_route53_record" "wordpress" {
  zone_id = var.zone_id
  name    = "wordpress.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_alb.application-lb.dns_name]
}
variable domain {
  type = string 

}

resource "aws_route53_record" "database_writer_endpoint" {
  zone_id = var.zone_id
  name    = "writer.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.writer_instance[0].endpoint]
}

resource "aws_route53_record" "database_reader_endpoint1" {
  zone_id = var.zone_id
  name    = "reader1.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.reader_instances[0].endpoint]
}

resource "aws_route53_record" "database_reader_endpoint2" {
  zone_id = var.zone_id
  name    = "reader2.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.reader_instances[1].endpoint]
}

resource "aws_route53_record" "database_reader_endpoint3" {
  zone_id = var.zone_id
  name    = "reader3.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.reader_instances[2].endpoint]
}