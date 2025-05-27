resource "aws_networkmanager_core_network" "this" {
  description = var.description
  global_network_id = aws_networkmanager_global_network.this.id

  tags = var.tags
}

resource "aws_networkmanager_global_network" "this" {
  description = var.global_description
  tags        = var.tags
}

resource "aws_networkmanager_core_network_policy_document" "this" {
  core_network_configuration {
    segments {
      name = "segment-1"
    }

    segments {
      name = "segment-2"
    }

    edges {
      source      = "segment-1"
      destination = "segment-2"
    }
  }
}

resource "aws_networkmanager_core_network_policy" "this" {
  core_network_id = aws_networkmanager_core_network.this.id
  policy_document = aws_networkmanager_core_network_policy_document.this.json
}
