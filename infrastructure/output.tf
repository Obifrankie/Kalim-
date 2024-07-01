output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main_igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.main_nat_gw.id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}

output "frontend_security_group_id" {
  value = aws_security_group.frontend_sg.id
}

output "backend_security_group_id" {
  value = aws_security_group.backend_sg.id
}

output "frontend_lb_dns_name" {
  value = aws_lb.frontend_lb.dns_name
}

output "backend_lb_dns_name" {
  value = aws_lb.backend_lb.dns_name
}
