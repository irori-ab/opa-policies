policy "enforce_mandatory_labels" {
  query             = "data.terraform.policies.labels"
  enforcement_level = "mandatory"
}
