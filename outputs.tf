output "id" {
  value = length(var.management_group_name) > 0 ? (
    one(azurerm_consumption_budget_management_group.this[*].id)
    ) : (
    length(var.resource_group_name) > 0 ? (
      one(azurerm_consumption_budget_resource_group.this[*].id)
      ) : (
      azurerm_consumption_budget_subscription.this.id
    )
  )
  description = "The budget ID."
}

