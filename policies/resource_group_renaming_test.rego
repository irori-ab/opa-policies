package policies.resource_group_renaming

# Test 1: Deny when an existing Resource Group is renamed
test_deny_resource_group_rename if {
	mock_input := {
		"resource_changes": [
			{
				"address": "azurerm_resource_group.user_rg",
				"type": "azurerm_resource_group",
				"change": {
					"actions": ["delete", "create"],
					"before": {
						"name": "resource-group-name-test",
					},
					"after": {
						"name": "resource-group-name-prod",
					},
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 2: Allow when the Resource Group name remains unchanged
test_allow_unchanged_resource_group_name if {
	mock_input := {
		"resource_changes": [
			{
				"address": "azurerm_resource_group.user_rg",
				"type": "azurerm_resource_group",
				"change": {
					"actions": ["update"],
					"before": {
						"name": "resource-group-name-test",
					},
					"after": {
						"name": "resource-group-name-test",
					},
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 0
}

# Test 3: Allow when an existing Resource Group is deleted
test_deny_resource_group_deletion if {
	mock_input := {
		"resource_changes": [
			{
				"address": "azurerm_resource_group.user_rg",
				"type": "azurerm_resource_group",
				"change": {
					"actions": ["delete"],
					"before": {
						"name": "resource-group-name-test",
					},
					"after": null,
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 0
}

# Test 4: Deny when a Resource Group is replaced
test_deny_resource_group_replacement if {
	mock_input := {
		"resource_changes": [
			{
				"address": "azurerm_resource_group.user_rg",
				"type": "azurerm_resource_group",
				"change": {
					"actions": ["delete", "create"],
					"before": {
						"name": "resource-group-name-test",
					},
					"after": {
						"name": "resource-group-name-test",
					},
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 1
}

# Test 5: Allow creation of a new Resource Group
test_allow_new_resource_group if {
	mock_input := {
		"resource_changes": [
			{
				"address": "azurerm_resource_group.new_rg",
				"type": "azurerm_resource_group",
				"change": {
					"actions": ["create"],
					"before": null,
					"after": {
						"name": "resource-group-name-test",
					},
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 0
}

# Test 6: Allow changes to unrelated resources
test_allow_unrelated_resource_changes if {
	mock_input := {
		"resource_changes": [
			{
				"address": "azurerm_linux_virtual_machine.example",
				"type": "azurerm_linux_virtual_machine",
				"change": {
					"actions": ["update"],
					"before": {
						"size": "Standard_D2s_v5",
					},
					"after": {
						"size": "Standard_D4s_v5",
					},
				},
			},
		],
	}

	results := deny with input as mock_input
	count(results) == 0
}
