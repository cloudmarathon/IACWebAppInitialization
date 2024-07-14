# terraform {
#   required_providers {
#     azurerm = "=3.100.0"
#   }
#   backend "remote" {
#     hostname     = var.terraform_hostname
#     organization = var.terraform_organization
#     workspaces {
#       name = var.terraform_workspace
#     }
#   }
# }
# terraform {
#   required_providers {
#     azurerm = "=3.100.0"
#   }
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "Terraform-IACS"
#     workspaces {
#       name = "IACS"
#     }
#   }
# }
terraform {
  required_providers {
    azurerm = "=3.100.0"
  }
  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "Terraform-IACS"
  #   workspaces {
  #     name = "IAC-webapp-test"
  #   }
  # }
}

provider "azurerm" {
  features {}
}