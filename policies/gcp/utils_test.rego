package terraform.policies.gcp.utils

test_gcp_resource if {
	mock_resource := {
		"address": "google_computer_instance.server",
		"type": "google_compute_instance",
		"change": {
			"actions": ["create"],
			"after": {},
		},
	}

	is_gcp_resource(mock_resource)
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

	not is_gcp_resource(mock_resource)
}
