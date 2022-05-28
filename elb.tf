resource "aws_lb" "alb" {
  name               = "ld4l-services-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = toset(data.aws_subnet_ids.public_subnets.ids)

  enable_deletion_protection = false

  tags = {
    Application          = "LD4P"
    "Cost Center"        = "L858313"
    "Functional Contact" = "elr37"
    "Technical Contact"  = "gad22"
  }
}

resource "aws_lb_target_group" "tg_ip_80" {
  name        = "ld4l-services-tg-80"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.selected_vpc.id
}

resource "aws_lb_target_group" "tg_ip_8080" {
  name        = "ld4l-services-tg-8080"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.selected_vpc.id
  health_check {
    matcher    = "200,302,404"
    path       = "/ld4l_services/fast.jsp"
  }
}


#resource "aws_lb_target_group" "tg_ip_443" {
#  name        = "ld4l-services-tg-443"
#  port        = 443
#  protocol    = "TCP"
#  target_type = "ip"
#  vpc_id      = data.aws_vpc.selected_vpc.id
#}

resource "aws_lb_listener" "alb_listener_80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_ip_8080.arn
  }
}

#resource "aws_lb_listener" "alb_listener_443" {
#  load_balancer_arn = aws_lb.alb.arn
#  port              = "443"
#  protocol          = "HTTPS"

#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.tg_ip_443.arn
#  }
#}

# Add ACM cert and attach to https listener
