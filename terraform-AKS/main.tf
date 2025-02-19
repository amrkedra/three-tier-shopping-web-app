# Fetch current Azure client configuration
data "azurerm_client_config" "current" {}

# Create a resource group
resource "azurerm_resource_group" "RG-Test-Amr" {
  name     = "RG-Test-Amr"
  location = "UAE North"
}

# Create a user-assigned managed identity
resource "azurerm_user_assigned_identity" "shopping-app-test-identity" {
  name                = "aks-managed-identity"
  resource_group_name = azurerm_resource_group.RG-Test-Amr.name
  location            = azurerm_resource_group.RG-Test-Amr.location
}

# Role Assignment for Networking Contributor
resource "azurerm_role_assignment" "network_contributor" {
  scope                = azurerm_resource_group.RG-Test-Amr.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.shopping-app-test-identity.principal_id

  depends_on = [azurerm_user_assigned_identity.shopping-app-test-identity]
}

# Role Assignment for Monitoring Metrics Publisher
resource "azurerm_role_assignment" "monitoring_metrics" {
  scope                = azurerm_resource_group.RG-Test-Amr.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.shopping-app-test-identity.principal_id

  depends_on = [azurerm_user_assigned_identity.shopping-app-test-identity]
}

# Uncomment and use this block if you need a Key Vault
# resource "azurerm_key_vault" "test-amr-kv" {
#   name                        = "test-amr-kv"
#   location                    = azurerm_resource_group.RG-Test-Amr.location
#   resource_group_name         = azurerm_resource_group.RG-Test-Amr.name
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false

#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     key_permissions = [
#       "Get", "List"
#     ]

#     secret_permissions = [
#       "Get", "List"
#     ]

#     storage_permissions = [
#       "Get", "List"
#     ]
#   }
# }

# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "amr-shopping-app-cluster" {
  name                = "amr-shopping-app-cluster"
  location            = azurerm_resource_group.RG-Test-Amr.location
  resource_group_name = azurerm_resource_group.RG-Test-Amr.name
  dns_prefix          = "akscluster"

  default_node_pool {
    name       = "nodepool01"
    node_count = 3
    vm_size    = "Standard_D2_v2"
    auto_scaling_enabled = true
    min_count = 1
    max_count = 3
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

# Output the kubeconfig
output "kube_config" {
  value     = azurerm_kubernetes_cluster.amr-shopping-app-cluster.kube_config_raw
  sensitive = true
}