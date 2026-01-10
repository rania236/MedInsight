# Variables for MedInsight Terraform configuration

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# =============================================================================
# MASTER NODE
# =============================================================================
variable "master_instance_id" {
  description = "Instance ID of the Kubernetes master node"
  type        = string
  default     = "i-0c909e0a81dbc5cd4"
}

variable "master_security_group_id" {
  description = "Security Group ID of the Master node (launch-wizard-1)"
  type        = string
  default     = "sg-0ae66191e0e0404dc"
}

# =============================================================================
# WORKER NODE
# =============================================================================
variable "worker1_instance_id" {
  description = "Instance ID of the Kubernetes worker node"
  type        = string
  default     = "i-06f915511a01d6c43"
}

variable "worker_security_group_id" {
  description = "Security Group ID of the Worker node (launch-wizard-2)"
  type        = string
  default     = "sg-0cb560fe7bbb55a8b"
}
