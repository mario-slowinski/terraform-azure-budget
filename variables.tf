variable "management_group_name" {
  type        = string
  description = "The name of the Management Group for which to create a consumption budget."
  default     = ""
}

variable "subscription_id" {
  type        = string
  description = "The ID of the Subscription for which to create a consumption budget."
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group for which to create the consumption budget."
  default     = ""
}

variable "name" {
  type        = string
  description = "The name which should be used for this Subscription Consumption Budget."
  default     = ""
}

variable "amount" {
  type        = number
  description = "The total amount of cost to track with the budget."
  default     = 500
}

variable "time_grain" {
  type        = string
  description = "The time covered by a budget. Tracking of the amount will be reset based on the time grain."
  default     = "Monthly"
}

variable "time_period" {
  type = object({
    start_date = string
    duration   = optional(string)
  })
  description = "A time_period block."
  default = {
    start_date = ""
    duration   = "87658h" # 10 years in hours
  }
}

variable "notifications" {
  type = list(object({
    operator       = string
    threshold      = number
    threshold_type = optional(string)
    contact_emails = optional(list(string))
    contact_groups = optional(list(string))
    contact_roles  = optional(list(string))
    enabled        = optional(bool)
  }))
  description = "One or more notification blocks."
  default = [
    {
      contact_roles = ["Owner"]
      operator      = "EqualTo"
      threshold     = 50.0
    },
    {
      contact_roles  = ["Owner"]
      operator       = "GreaterThan"
      threshold      = 100.0
      threshold_type = "Forecasted"
    },
  ]
}

variable "filter" {
  type = object({
    dimension = optional(object({
      name   = string
      values = list(string)
    }))
    tag = optional(object({
      name   = string
      values = list(string)
    }))
  })
  description = "A filter block."
  default     = {}
}
