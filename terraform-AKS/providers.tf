terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }

  }

}

provider "aws" {
  region  = "me-south-1"
  profile = "default"
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
}