variable "name" {
  type       = string
  default     = "kk-test"
}
variable "privileged_mode" {
  default     = true
  description = "Set to `false` to prevent Database accessibility"
  type        = bool
}
variable "cluster_name" {
  description = "The resource name."
  type        = string
  default     = null
}
variable "repositoryname" {
  description = "The resource name."
  type        = string
  default     = null
}
variable "branchname" {
  description = "The resource name."
  type        = string
  default     = null
}
variable "execution_role" {
  description = "The resource name."
  type        = string
  default     = null
}

variable "listener_arns" {
  description = "The resource name."
  type        = list(string)
  default     = null
}
variable "target_group_0" {
  description = "The resource name."
  type        = string
  default     = null
}
variable "target_group_1" {
  description = "The resource name."
  type        = string
  default     = null
}

variable "IMAGE_REPO_NAME" {
  description = "The resource name."
  type        = string
  default     = null
}
variable "SERVICE_PORT" {
  description = "The resource name."
  type        = string
  default     = null
}

variable "compute_type" {
  description = "The resource name."
  type        = string
  default     = null
}

variable "MEMORY_RESV" {
  description = "The resource name."
  type        = string
  default     = null
}

variable "service_name" {
  description = "The resource name."
  type        = string
  default     = null
}

variable "aws_account_id" {
  default = ""
}

variable "region" {
  default = "us-west-2"
}
variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources"
  type        = map(string)
}
