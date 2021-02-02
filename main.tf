resource "aws_instance" "myec" {
  ami           = "ami-01aab85a5e4a5a0fe"
  instance_type = variable.instance_type
  key_name      = "nimesh1"

  provisioner "local-exec" {
    //  command = "echo ${aws_instance.myec2.availability_zone} >abcd.txt"
    when    = destroy
    command = "echo hello"
  }
  provisioner "remote-exec" {
    inline = [
      "date",
      "touch abcd.txt"
    ]
    on_failure = continue
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./nimesh1.pem")
      host        = self.public_ip
    }
  }
}

