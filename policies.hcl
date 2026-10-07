policy "enforce_mandatory_labels" {
  query             = "data.terraform.policies.gcp.labels"
  enforcement_level = "mandatory"
}
