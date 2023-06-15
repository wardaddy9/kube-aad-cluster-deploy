#Creating service principal that we will use to deploy to the cluster
resource "azuread_application" "app" {
  display_name = var.spn_name
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "spn" {
  application_id = azuread_application.app.application_id
}
#The above principal and password we be used in providers.tf file login to AKS cluster
resource "azuread_service_principal_password" "spn_password" {
  service_principal_id = azuread_service_principal.spn.id
}
#Creating the AAD group
resource "azuread_group" "aks_admins" {
  display_name     = var.aad_group_aks_admins
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
#into this group adding owners to SPN we create and adding myself to AKS admin
  members = [
    data.azuread_client_config.current.object_id,
    azuread_service_principal.spn.object_id,
  ]
}
