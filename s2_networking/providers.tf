terraform {
  required_providers {
    azurerm = "=3.100.0"
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}