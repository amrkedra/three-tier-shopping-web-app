variable "subscription_id" {
  description = "The subscription ID for the Azure subscription"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription"
  type        = string
}

variable "client_id" {
  description = "The client ID for the service principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret for the service principal"
  type        = string
  sensitive   = true
}