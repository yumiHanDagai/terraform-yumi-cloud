variable "linux_instance_type" {
  type = string
  default = "t2.micro"
}
variable "linux_instance_name" {
  type = string
  default = "fail_linux_tfc"
}
variable "windows_instance_type" {
  type = string
  default = "t2.small"
}
variable "windows_instance_name" {
  type = string
  default = "fail_windows_tfc"
}
variable "user_name" {
  type = string
  default = "fail_user"
}
variable "policy_name" {
  type = string
  default = "fail_policy"
}
