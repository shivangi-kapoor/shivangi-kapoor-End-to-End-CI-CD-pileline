resource "aws_instance" "jenkins_server" {

  ami           = "ami-02167eae61967e403"
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "devops-jenkins-server"
    Environment = "dev"
    Project     = "CI-CD-Pipeline"
  }
}