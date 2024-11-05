# aws_lb

resource "aws_lb" "nginx" {
  name               = "global-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_nginx_sg.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.public_subnet2.id]

  enable_deletion_protection = false

  tags = local.common_tags
}

# aws_lb_target_group

resource "aws_lb_target_group" "nginx" {
  name     = "nginx-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app.id

  tags = local.common_tags
}

resource "aws_lb_target_group_attachment" "nginx_tg_attach" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "nginx_tg_attach2" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx2.id
  port             = 80
}

resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}