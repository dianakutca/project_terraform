resource "aws_route53_record" "wordpress" {
  zone_id = "Z02170421JNU7XEVMBN6G"
  name    = "wordpress.treenetsolution.com"
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

resource "aws_route53_record" "database_reader_endpoint1" {
  zone_id = "Z02170421JNU7XEVMBN6G"
  name    = "reader1.treenetsolution.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.reader_instances[0].endpoint]
}

resource "aws_route53_record" "database_reader_endpoint2" {
  zone_id = "Z02170421JNU7XEVMBN6G"
  name    = "reader2.treenetsolution.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.reader_instances[1].endpoint]
}

resource "aws_route53_record" "database_reader_endpoint3" {
  zone_id = "Z02170421JNU7XEVMBN6G"
  name    = "reader3.treenetsolution.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster_instance.reader_instances[2].endpoint]
}