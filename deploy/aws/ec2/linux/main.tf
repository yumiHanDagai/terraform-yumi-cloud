resource "aws_instance" "linux_example" {
  ami           = "ami-09a73d1fbb2515f95"
  instance_type = var.linux_instance_type
  subnet_id     = "subnet-07b73439a9be9b6b4"
  vpc_security_group_ids = ["sg-018282f50b7f54bc5"]
  tags = {
    Name = var.linux_instance_name
  }
}
