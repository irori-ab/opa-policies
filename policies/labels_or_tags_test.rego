package terraform.policies.labels

# Test 1: Deny when a GCP resource is missing required labels
test_missing_labels if {
	mock_input := {
		"plan": {
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
		},
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 2: Allow when all required GCP labels are present
test_valid_labels if {
	mock_input := {
		"plan": {
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
		},
	}

	results := deny with input as mock_input
	count(results) == 0
}

# Test 1: Deny when an AWS resource is missing required tags
test_aws_missing_tags if {
	mock_input := {
		"plan": {
			"resource_changes": [
				{
					"address": "aws_s3_bucket.non_compliant",
					"type": "aws_s3_bucket",
					"change": {
						"actions": ["create"],
						"after": {
							"tags": {},
						},
					},
				},
			],
		},
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 2: Allow when all required AWS tags are present
test_aws_valid_tags if {
	mock_input := {
		"plan": {
			"resource_changes": [
				{
					"address": "aws_instance.compliant",
					"type": "aws_instance",
					"change": {
						"actions": ["create"],
						"after": {
							"tags": {
								"env_owner": "xyz",
							},
						},
					},
				},
			],
		},
	}

	results := deny with input as mock_input
	count(results) == 0
}

# Test 3: Deny when an Azure resource is missing required tags
test_azure_missing_tags if {
	mock_input := {
		"plan": {
			"resource_changes": [
				{
					"address": "azurerm_storage_account.non_compliant",
					"type": "azurerm_storage_account",
					"change": {
						"actions": ["create"],
						"after": {
							"tags": {},
						},
					},
				},
			],
		},
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 4: Allow when all required Azure tags are present
test_azure_valid_tags if {
	mock_input := {
		"plan": {
			"resource_changes": [
				{
					"address": "azurerm_linux_virtual_machine.compliant",
					"type": "azurerm_linux_virtual_machine",
					"change": {
						"actions": ["create"],
						"after": {
							"tags": {
								"env_owner": "abc",
							},
						},
					},
				},
			],
		},
	}

	results := deny with input as mock_input
	count(results) == 0
}
