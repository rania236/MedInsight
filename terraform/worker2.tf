# New worker node for MedInsight Kubernetes cluster

resource "aws_instance" "worker2" {
  ami                    = data.aws_instance.worker1.ami
  instance_type          = "t3.large" # 2 vCPU, 8 Go RAM
  subnet_id              = data.aws_instance.worker1.subnet_id
  vpc_security_group_ids = [var.worker_security_group_id]
  key_name               = data.aws_instance.worker1.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = "worker2-Monitoring"
  }
}

data "aws_instance" "worker2" {
  instance_id = aws_instance.worker2.id
}
