package terraform.policies.gcp.labels

# Test 1: Deny when a GCP resource is missing required labels
test_missing_labels if {
	mock_input := {
		"resource_changes": [
			{
				"address": "google_storage_bucket.non_compliant",
				"type": "google_storage_bucket",
				"change": {
					"actions": ["create"],
					"after": {
						"labels": {},
					},
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 2: Allow when all required GCP labels are present
test_valid_labels if {
	mock_input := {
		"resource_changes": [
			{
				"address": "google_compute_instance.compliant",
				"type": "google_compute_instance",
				"change": {
					"actions": ["create"],
					"after": {
						"labels": {
							"env_owner": "iruri",
						},
					},
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 0
}
