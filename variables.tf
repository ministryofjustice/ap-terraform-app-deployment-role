variable "tags" {
  description = "The tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "organisation" {
  description = "The name of the GitHub organisation or user"
  type        = string
}

variable "repo" {
  description = "The name of the GitHub repository"
  type        = string
}

variable "openid_connect_provider_arn" {
  description = "The ARN of the AWS IAM OpenID connect provider"
  type        = string
}

variable "permissions_boundary" {
  description = "(Optional) ARN of the policy that is used to set the permissions boundary for the role"
  type        = string
  default     = null
}
