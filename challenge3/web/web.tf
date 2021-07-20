data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [module.sg.sg_name]
  user_data = file("./web/server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

output "pub_ip" {
  value = module.eip.PublicIP
}

module "eip" {
  source = "../eip"
  instance_id = aws_instance.web.id
}

module "sg" {
  source = "../sg"
}
