module "ec2_linux" {
  source = "./ec2/linux"
  linux_instance_type = var.linux_instance_type
  linux_instance_name = var.linux_instance_name
}

module "ec2_windows" {
  source = "./ec2/windows"
  windows_instance_type = var.windows_instance_type
  windows_instance_name = var.windows_instance_name
}

module "iam_user" {
  source = "./iam/user"
  user_name = var.user_name
}

module "iam_custompolicy" {
  source = "./iam/custompolicy"
  policy_name = var.policy_name
}

resource "aws_ec2_transit_gateway" "tgw" {
  description                     = "Core Transit Gateway"
  auto_accept_shared_attachments = "enable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attach" {
  vpc_id             = "vpc-02e65ee117640d3c3" 
  subnet_ids         = ["subnet-07b73439a9be9b6b4"] 
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_vpc_endpoint" "s3_private" {
  vpc_id            = "vpc-02e65ee117640d3c3"  
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Interface"
  security_group_ids = ["sg-0477797d3a1998110"]    
  private_dns_enabled = true                    
}
