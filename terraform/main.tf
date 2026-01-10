# Terraform configuration for MedInsight AWS Infrastructure
# This config adds missing security rules to existing security groups

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# =============================================================================
# DATA SOURCES - Reference existing resources
# =============================================================================

data "aws_instance" "master" {
  instance_id = var.master_instance_id
}

data "aws_instance" "worker1" {
  instance_id = var.worker1_instance_id
}

# =============================================================================
# MASTER SECURITY GROUP RULES - Add missing ports
# =============================================================================

# Add Kubernetes API Server port (6443) - CRITICAL for GitHub Actions
resource "aws_security_group_rule" "master_k8s_api" {
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.master_security_group_id
  description       = "Kubernetes API Server - Required for GitHub Actions"
}

# Add etcd ports
resource "aws_security_group_rule" "master_etcd" {
  type              = "ingress"
  from_port         = 2379
  to_port           = 2380
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.master_security_group_id
  description       = "etcd server client API"
}

# Add Kubelet API port
resource "aws_security_group_rule" "master_kubelet" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10250
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.master_security_group_id
  description       = "Kubelet API"
}

# Add NodePort range (30000-32767) - already have 32443, but add full range
resource "aws_security_group_rule" "master_nodeport" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.master_security_group_id
  description       = "NodePort Services"
}

# Add Flannel VXLAN
resource "aws_security_group_rule" "master_flannel" {
  type              = "ingress"
  from_port         = 8472
  to_port           = 8472
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.master_security_group_id
  description       = "Flannel VXLAN overlay network"
}

# =============================================================================
# WORKER SECURITY GROUP RULES - Add K8s ports
# =============================================================================

# Add Kubelet API port
resource "aws_security_group_rule" "worker_kubelet" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10250
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.worker_security_group_id
  description       = "Kubelet API"
}

# Add NodePort range
resource "aws_security_group_rule" "worker_nodeport" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.worker_security_group_id
  description       = "NodePort Services"
}

# Add Flannel VXLAN
resource "aws_security_group_rule" "worker_flannel" {
  type              = "ingress"
  from_port         = 8472
  to_port           = 8472
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.worker_security_group_id
  description       = "Flannel VXLAN overlay network"
}

