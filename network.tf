data "aws_availability_zones" "available" {
  state = "available"
}

module "app" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"
  cidr = var.vpc_cidr_block

  azs             = slice(data.aws_availability_zones.available.names, 0, var.vpc_public_subnet_count)
  public_subnets  = [for subnet in range(var.vpc_public_subnet_count) : cidrsubnet(var.vpc_cidr_block, 8, subnet)]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_dns_hostnames = true
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-vpc" })
}

resource "aws_security_group" "nginx_sg" {
  name   = "${local.naming_prefix}-nginx_sg"
  vpc_id = module.app.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-nginx-sg" })
}

resource "aws_security_group" "alb_nginx_sg" {
  name   = "nginx_alb_sg"
  vpc_id = module.app.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-alb-sg" })
}
