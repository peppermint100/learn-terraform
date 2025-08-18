resource "aws_instance" "example_server" {
  ami           = "ami-0dd97ebb907cf9366"
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  user_data = templatefile("${path.module}/templates/web.tpl", {
    "region" = "ap-northeast-2"
  })

  key_name = aws_key_pair.mykey.key_name
  user_data_replace_on_change = true

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("${path.module}/mykey")
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.module}/mykey.pub")
}