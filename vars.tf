variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "instance_type" {
  type = map(string)
  default = {
    micro  = "t2.micro"
    small  = "t2.small"
    medium = "t2.medium"
  }
}

variable "vpc_public_subnet_count" {
  type        = number
  description = "Number of public subnets to create"
  default     = 2
}

variable "instance_count" {
  type        = number
  description = "Number of public subnets to create"
  default     = 2
}

variable "company" {
  type        = string
  description = "Company Name Tag"
  default     = "Software Company"
}

variable "project" {
  type        = string
  description = "Project Name Tag"
}

variable "billing_code" {
  type        = string
  description = "Billing Code Tag"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources"
  default     = "corp-app"
}

variable "environment" {
  type        = string
  description = "Environment for the resources"
  default     = "dev"
}