terraform {
  required_providers {
    azurerm = "=3.100.0"
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Terraform-IACS"
    workspaces {
      name = "IACS"
    }
  }
}

provider "azurerm" {
  features {}
}