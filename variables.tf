variable "vpc_cidr" {
  description = "The CIDR block for the entire VPC"
  default     = "10.123.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.123.101.0/24"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  default     = "10.123.201.0/24"
}

variable "key_path" {
  description = "Path to the private portion of the SSH key specified."
}

variable "key_pub_path" {
  description = "Path to the public portion of the SSH key specified."
}

variable "key_name" {
  description = "A name for the SSH key specified."
  default     = "rsa-terraform-test-key"
}

variable "aws_region" {
  description = "AWS region."
  default     = "us-east-1"
}
