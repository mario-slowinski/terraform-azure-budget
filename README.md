azure-budget
============

Depending on given variable Terraform Azure Budget for:

* [Management Group](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview)
* [Subscription](https://learn.microsoft.com/en-us/azure/azure-portal/get-subscription-tenant-id)
* [Resource Group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)

Required providers
------------------

* [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

Variables
--------------

* `management_group_name`: The name of the Management Group for which to create a consumption budget.
* `subscription_id`: The ID of the Subscription for which to create a Consumption budget.
* `resource_group_name`: The name of the Resource Group for which to create the consumption budget.

* `name`: The name which should be used for this Subscription Consumption Budget.
* `amount`: The total amount of cost to track with the budget.
* `time_grain`: The time covered by a budget. Tracking of the amount will be reset based on the time grain.
* `time_period`: A time_period block.
  * `start_date`: The start date for the budget (default: first day of current month).
  * `duration`: Budget duration in hours (default: 10 years).
* `notifications`: One or more notification blocks.
  * `operator`: The comparison operator for the notification. Must be one of `EqualTo`, `GreaterThan`, or `GreaterThanOrEqualTo`.
  * `threshold`: Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000.
  * `threshold_type`: The type of threshold for the notification. This determines whether the notification is triggered by forecasted costs or actual costs. The allowed values are
 `Actual` and `Forecasted`. Default is `Actual`.
  * `contact_emails`: Specifies a list of email addresses to send the budget notification to when the threshold is exceeded.
  * `contact_groups`: Specifies a list of Action Group IDs to send the budget notification to when the threshold is exceeded.
  * `contact_roles`: Specifies a list of contact roles to send the budget notification to when the threshold is exceeded.
  * `enabled`: Should the notification be enabled? Defaults to `true`.
* `filter`: A filter block.
  * `dimension`: One or more `dimension` blocks as defined below to filter the budget on.
    * `name`: The name of the column to use for the filter. The allowed values are:
      * `ChargeType`
      * `Frequency`
      * `InvoiceId`
      * `Meter`
      * `MeterCategory`
      * `MeterSubCategory`
      * `PartNumber`
      * `PricingModel`
      * `Product`
      * `ProductOrderId`
      * `ProductOrderName`
      * `PublisherType`
      * `ReservationId`
      * `ReservationName`
      * `ResourceGroupName`
      * `ResourceGuid`
      * `ResourceId`
      * `ResourceLocation`
      * `ResourceType`
      * `ServiceFamily`
      * `ServiceName`
      * `SubscriptionID`
      * `SubscriptionName`
      * `UnitOfMeasure`
    * `values`: Specifies a list of values for the column.
  * `tag`: One or more `tag` blocks as defined below to filter the budget on.
    * `name`: The name of the tag to use for the filter.
    * `values`: Specifies a list of values for the tag.

Outputs
--------------

* `id`: The budget ID

Dependencies
------------

*No* *dependencies*

Examples
--------

* `main.tf`

  ```terraform
  module "azure-budget" {
    sources = "github.com/mario-slowinski/terraform-azure-budget"
  }
  ```

License
-------

[GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html)

Author Information
------------------

[mario.slowinski@gmail.com](mailto:mario.slowinski@gmail.com)
