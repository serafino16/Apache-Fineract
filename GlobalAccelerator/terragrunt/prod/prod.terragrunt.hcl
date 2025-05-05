
include {
  path = find_in_parent_folders()
}


inputs = {
  accelerator_name    = local.accelerator_name
  endpoint_groups     = local.endpoint_groups["prod"]
  deletion_protection = false
  tags                = merge(local.tags, {
    "Environment" = "Prod"
  })
}
