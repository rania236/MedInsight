
output "worker2_public_ip" {
  description = "Elastic IP of the Worker2 node"
  value       = aws_eip.worker2.public_ip
}

output "worker2_private_ip" {
  description = "Private IP of the Worker2 node"
  value       = data.aws_instance.worker2.private_ip
}
# Outputs for MedInsight Terraform configuration

output "master_public_ip" {
  description = "Public IP of the Master node"
  value       = data.aws_instance.master.public_ip
}

output "master_private_ip" {
  description = "Private IP of the Master node"
  value       = data.aws_instance.master.private_ip
}

output "worker1_public_ip" {
  description = "Public IP of the Worker1 node"
  value       = data.aws_instance.worker1.public_ip
}

output "worker1_private_ip" {
  description = "Private IP of the Worker1 node"
  value       = data.aws_instance.worker1.private_ip
}

output "master_security_group_id" {
  description = "Security Group ID of Master node"
  value       = var.master_security_group_id
}

output "worker_security_group_id" {
  description = "Security Group ID of Worker node"
  value       = var.worker_security_group_id
}

output "kubernetes_api_endpoint" {
  description = "Kubernetes API endpoint (for kubeconfig)"
  value       = "https://${data.aws_instance.master.public_ip}:6443"
}

