resource "aws_instance" "windows_example" {
  ami           = "ami-01d033a4281b702a8"
  instance_type = var.windows_instance_type
  subnet_id     = "subnet-07b73439a9be9b6b4"
  vpc_security_group_ids = ["sg-0477797d3a1998110"]
  key_name      = "zxw-test"
  tags = {
    Name = var.windows_instance_name
  }
  
  # Windows专用配置
  get_password_data = true
  user_data         = <<-EOF
    <powershell>
    # 示例初始化脚本
    Set-ExecutionPolicy Bypass -Scope Process -Force
    </powershell>
  EOF
}
