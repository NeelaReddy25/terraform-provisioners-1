resource "aws_instance" "db" {
  ami = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = ["sg-039a1e225ec0846a9"]
  instance_type = "t3.micro"

  #provisioners will run when you are creating resources.
  #They will not run once the resources are created.
  provisioner "local-exec" {
    command = "echo ${self.private_ip} > private_ips.txt" #self is aws_instance.web
  }

#   provisioner "local-exec" {
#     command = "ansible-playbook -i private_ips.txt web.yaml"
#   }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
        "sudo dnf install ansible -y",
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx"
     ]
  }
}