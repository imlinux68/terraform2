data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20230418.0-x86_64-gp2"]
  }
}

resource "random_id" "mtc_node_id" {
    byte_length = 2
    count = var.main_instance_count
}

resource "aws_instance" "mtc_main" {
  count = var.main_instance_count
  instance_type = var.main_instance_type
  ami = data.aws_ami.server_ami.id
  # key_name = ""
  vpc_security_group_ids = [aws_security_group.mtc_sg1.id]
  subnet_id = aws_subnet.mtc_public_subnet[count.index].id
  root_block_device {
    volume_size = var.main_vol_size
  }

  tags = {
    "Name" = "mtc-main-${random_id.mtc_node_id[count.index].dec}"
  }
}