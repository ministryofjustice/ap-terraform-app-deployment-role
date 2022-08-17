variable "tags" {
  description = "The tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "organisation" {
  description = "The name of the GitHub organisation or user"
}

variable "repo" {
  description = "The name of the GitHub repository"
}

variable "openid_connect_provider_arn" {
  description = "The ARN of the AWS IAM OpenID connect provider"
}
