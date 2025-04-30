output "waf_web_acl_ids" {
  description = "Web ACL IDs per environment"
  value = {
    for k, v in aws_waf_web_acl.waf : k => v.id
  }
}

output "waf_web_acl_arns" {
  description = "Web ACL ARNs per environment"
  value = {
    for k, v in aws_waf_web_acl.waf : k => v.arn
  }
}
