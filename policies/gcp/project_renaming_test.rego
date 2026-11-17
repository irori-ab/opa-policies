package policies.gcp_project_renaming

# Test 1: Deny project name changes
test_deny_project_name_change if {
	mock_input := {
		"resource_changes": [{
			"address": "google_project.my_project",
			"type": "google_project",
			"change": {
				"actions": ["update"],
				"before": {
					"name": "production",
					"project_id": "company-prod-123",
				},
				"after": {
					"name": "production-new",
					"project_id": "company-prod-123",
				},
			},
		}],
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 2: Deny project ID changes
test_deny_project_id_change if {
	mock_input := {
		"resource_changes": [{
			"address": "google_project.my_project",
			"type": "google_project",
			"change": {
				"actions": ["update"],
				"before": {
					"name": "production",
					"project_id": "company-prod-123",
				},
				"after": {
					"name": "production",
					"project_id": "company-prod-456",
				},
			},
		}],
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 3: Allow when project name and ID remain unchanged
test_allow_unchanged_project if {
	mock_input := {
		"resource_changes": [{
			"address": "google_project.my_project",
			"type": "google_project",
			"change": {
				"actions": ["update"],
				"before": {
					"name": "production",
					"project_id": "company-prod-123",
				},
				"after": {
					"name": "production",
					"project_id": "company-prod-123",
				},
			},
		}],
	}

	results := deny with input as mock_input
	count(results) == 0
}

# Test 4: Allow creation of a new project
test_allow_project_creation if {
	mock_input := {
		"resource_changes": [{
			"address": "google_project.my_project",
			"type": "google_project",
			"change": {
				"actions": ["create"],
				"before": null,
				"after": {
					"name": "production",
					"project_id": "company-prod-123",
				},
			},
		}],
	}

	results := deny with input as mock_input
	count(results) == 0
}
