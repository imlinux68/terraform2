data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20230418.0-x86_64-gp2"]
  }
}