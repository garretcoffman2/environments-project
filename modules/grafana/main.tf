resource "aws_instance" "grafana" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = element(var.public_subnet_ids, 0)
  security_groups = [aws_security_group.grafana_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y grafana
              systemctl start grafana-server
              EOF

  tags = var.tags
}

output "public_dns" {
  value = aws_instance.grafana.public_dns
}
