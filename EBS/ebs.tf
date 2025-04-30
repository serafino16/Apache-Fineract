resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone

  size              = var.size
  type              = var.type
  encrypted         = var.encrypted
  kms_key_id        = var.kms_key_id
  iops              = var.iops
  throughput        = var.throughput
  snapshot_id       = var.snapshot_id
  multi_attach_enabled = var.multi_attach_enabled

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}
