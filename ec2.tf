resource "aws_instance" "db" {
  ami = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = ["sg-039a1e225ec0846a9"]
  instance_type = "t3.micro"

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > private_ips.txt" #self is aws_instance.web
  }
}