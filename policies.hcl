policy "enforce_mandatory_labels" {
  query             = "data.terraform.policies.labels.deny"
  enforcement_level = "mandatory"
}
