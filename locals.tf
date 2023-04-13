locals {
  name = join("_", [
    var.time_grain,
    var.amount,
    ]
  )
  firstdayofmonth = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
}
