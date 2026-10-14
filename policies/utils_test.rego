package terraform.policies.utils

test_gcp_resource if {
	mock_resource := {
		"address": "google_compute_instance.server",
		"type": "google_compute_instance",
		"change": {
			"actions": ["create"],
			"after": {},
		},
	}

	is_cloud_resource(mock_resource)
}

test_non_gcp_resource if {
	mock_resource := {
		"address": "random_resource.server",
		"type": "random_resource",
		"change": {
			"actions": ["create"],
			"after": {},
		},
	}

	not is_cloud_resource(mock_resource)
}

test_aws_resource if {
	mock_resource := {
		"address": "aws_s3_bucket.non_compliant",
		"type": "aws_s3_bucket",
		"change": {
			"actions": ["create"],
			"after": {},
		},
	}

	is_cloud_resource(mock_resource)
}

test_non_aws_resource if {
	mock_resource := {
		"address": "random_resource.server",
		"type": "random_resource",
		"change": {
			"actions": ["create"],
			"after": {},
		},
	}

	not is_cloud_resource(mock_resource)
}

test_azure_resource if {
	mock_resource := {
		"address": "azurerm_storage_account.non_compliant",
		"type": "azurerm_storage_account",
		"change": {
			"actions": ["create"],
			"after": {},
		},
	}

	is_cloud_resource(mock_resource)
}

test_non_azure_resource if {
	mock_resource := {
		"address": "random_resource.server",
		"type": "random_resource",
		"change": {
			"actions": ["create"],
			"after": {},
		},
	}

	not is_cloud_resource(mock_resource)
}
