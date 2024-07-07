# Launch Configuration for Frontend# Launch Configuration for Frontend
resource "aws_launch_configuration" "frontend_lc" {
  name                        = var.frontend_lc_name
  image_id                    = var.image_id
  key_name                    = aws_key_pair.generated_key_pair.key_name
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.frontend_sg.id]
  associate_public_ip_address = true # Ensure public IP address is associated

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y ca-certificates curl
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc

                # Add the repository to Apt sources
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                EOF

  lifecycle {
    create_before_destroy = true
  }
}


# Launch Configuration for Backend
resource "aws_launch_configuration" "backend_lc" {
  name                        = var.backend_lc_name
  image_id                    = var.image_id
  key_name                    = aws_key_pair.generated_key_pair.key_name
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.backend_sg.id]
  associate_public_ip_address = true # Ensure public IP address is associated

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y ca-certificates curl
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc

                # Add the repository to Apt sources
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                EOF

  lifecycle {
    create_before_destroy = true
  }
}

# Launch Configuration for Backend
# resource "aws_launch_configuration" "backend_lc" {
#   name            = var.backend_lc_name
#   image_id        = var.image_id
#   key_name        = aws_key_pair.generated_key_pair.key_name
#   instance_type   = "t2.micro"
#   security_groups = [aws_security_group.backend_sg.id]
#   associate_public_ip_address = true  # Ensure public IP address is associated

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# Auto Scaling Group for Frontend
resource "aws_autoscaling_group" "frontend_asg" {
  launch_configuration = aws_launch_configuration.frontend_lc.id
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id] # Include both public subnets

  tag {
    key                 = "Name"
    value               = "frontend_asg"
    propagate_at_launch = true
  }
}

# Auto Scaling Group for Backend
resource "aws_autoscaling_group" "backend_asg" {
  launch_configuration = aws_launch_configuration.backend_lc.id
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id] # Use public subnets

  tag {
    key                 = "Name"
    value               = "backend_asg"
    propagate_at_launch = true
  }
}

# Load Balancer for Frontend
resource "aws_lb" "frontend_lb" {
  name               = var.frontend_lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend_sg.id]
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = var.frontend_lb_name
  }
}

# Load Balancer for Backend
resource "aws_lb" "backend_lb" {
  name               = var.backend_lb_name
  internal           = false # Assuming backend should be externally accessible
  load_balancer_type = "application"
  security_groups    = [aws_security_group.backend_sg.id]
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = var.backend_lb_name
  }
}


# Target Group for Frontend
resource "aws_lb_target_group" "frontend_tg" {
  name     = var.frontend_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = var.frontend_tg_name
  }
}

# Target Group for Backend
resource "aws_lb_target_group" "backend_tg" {
  name     = var.backend_tg_name
  port     = 8080 # Assuming backend instances are listening on port 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = var.backend_tg_name
  }
}

# Listener for Frontend Load Balancer
resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.frontend_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

# Listener for Backend Load Balancer
resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_lb.arn
  port              = "8080" # Assuming backend instances are listening on port 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

# Auto Scaling Group Attachments
resource "aws_autoscaling_attachment" "frontend_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.frontend_asg.name
  alb_target_group_arn   = aws_lb_target_group.frontend_tg.arn
}

resource "aws_autoscaling_attachment" "backend_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.backend_asg.name
  alb_target_group_arn   = aws_lb_target_group.backend_tg.arn
}