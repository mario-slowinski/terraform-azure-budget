data "azurerm_resource_group" "this" {
  count = length(var.resource_group_name) > 0 ? 1 : 0

  name = var.resource_group_name
}

resource "azurerm_consumption_budget_resource_group" "this" {
  count = length(var.resource_group_name) > 0 ? 1 : 0

  resource_group_id = one(data.azurerm_resource_group.this[*].id)
  name              = coalesce(var.name, local.name)

  amount     = var.amount
  time_grain = var.time_grain

  time_period {
    start_date = local.firstdayofmonth
    end_date   = timeadd(local.firstdayofmonth, var.time_period.duration)
  }

  dynamic "filter" {
    for_each = var.filter.dimension != null && var.filter.tag != null ? toset([1]) : toset([])

    content {
      dynamic "dimension" {
        for_each = length(var.filter.dimension.name) > 0 ? toset([1]) : toset([])

        content {
          name   = var.filter.dimension.name
          values = var.filter.dimension.values
        }
      }

      dynamic "tag" {
        for_each = length(var.filter.tag.name) > 0 ? toset([1]) : toset([])

        content {
          name   = var.filter.tag.name
          values = var.filter.tag.values
        }
      }
    }
  }

  dynamic "notification" {
    for_each = var.notifications

    content {
      enabled        = notification.value.enabled
      threshold      = notification.value.threshold
      threshold_type = notification.value.threshold_type
      operator       = notification.value.operator

      contact_emails = notification.value.contact_emails
      contact_groups = notification.value.contact_groups
      contact_roles  = notification.value.contact_roles
    }
  }

  lifecycle {
    ignore_changes = [
      time_period[0].start_date,
      time_period[0].end_date,
    ]
  }
}
