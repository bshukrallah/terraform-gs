output "aws_instance_public_dns" {
  value = "http://${aws_instance.nginx1.public_dns}"
}

output "aws_alb_public_dns" {
  value = "http://${aws_lb.nginx.dns_name}"
}