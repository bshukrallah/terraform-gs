output "aws_instance_public_dns" {
  value = [for dns in aws_instance.nginx[*].public_dns : "http://${dns}"]
}

output "aws_alb_public_dns" {
  value = "http://${aws_lb.nginx.dns_name}"
}