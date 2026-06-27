resource "local_file" "ansible_inventory" {

  filename = "../ansible/inventory.ini"

  content = <<EOF
[jenkins_server]
${aws_instance.jenkins_server.public_ip} ansible_user=ubuntu project_private_key= /home/shivangi/.ssh/project.pem
EOF
}
