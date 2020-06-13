/*-----------------------------------------------------------------------------8
|                                                                              |
|                                Admin - NSG                                   |
|                                                                              |
+--------------------------------------4--------------------------------------*/

# NSGs ===========================================================================================================

# Creates mgmt subnet nsg
resource "azurerm_network_security_group" "nsg-mgmt" {
  count               = var.infrastructure.vnets.management.subnet_mgmt.nsg.is_existing ? 0 : 1
  name                = var.infrastructure.vnets.management.subnet_mgmt.nsg.name
  location            = var.infrastructure.region
  resource_group_name = var.infrastructure.vnets.management.is_existing ? data.azurerm_virtual_network.vnet-management[0].resource_group_name : azurerm_virtual_network.vnet-management[0].resource_group_name
}

# Imports the mgmt subnet nsg data
data "azurerm_network_security_group" "nsg-mgmt" {
  count               = var.infrastructure.vnets.management.subnet_mgmt.nsg.is_existing ? 1 : 0
  name                = split("/", var.infrastructure.vnets.management.subnet_mgmt.nsg.arm_id)[8]
  resource_group_name = split("/", var.infrastructure.vnets.management.subnet_mgmt.nsg.arm_id)[4]
}