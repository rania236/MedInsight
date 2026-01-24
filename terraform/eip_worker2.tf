# Allocate and associate an Elastic IP for worker2

resource "aws_eip" "worker2" {
  domain = "vpc"
  depends_on = [aws_instance.worker2]
  tags = {
    Name = "medinsight-worker2-eip"
  }
}

resource "aws_eip_association" "worker2" {
  instance_id   = aws_instance.worker2.id
  allocation_id = aws_eip.worker2.id
}
