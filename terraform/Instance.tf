resource "aws_instance" "jenkins_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  tags = {
    Name        = "devops-jenkins-server"
    Environment = "dev"
    Project     = "CI-CD-Pipeline"
  }
  
}