package policies.resource_group_renaming

# Deny Resource Group renaming
deny contains violation if {
	some resource in input.resource_changes
	resource.type == "azurerm_resource_group"

	before := resource.change.before.name
	after := resource.change.after.name

	before != after
	before != null
	after != null

	violation := {
		"msg": sprintf(
			"Resource Group name change is not allowed: %s (%s -> %s)",
			[resource.address, before, after],
		),
	}
}

# Deny Resource Group replacement, unless already caught as a rename
deny contains violation if {
	some resource in input.resource_changes
	resource.type == "azurerm_resource_group"

	resource.change.actions == ["delete", "create"]

	before := resource.change.before.name
	after := resource.change.after.name

	before == after

	violation := {
		"msg": sprintf(
			"Replacing Resource Group is not allowed: %s",
			[resource.address],
		),
	}
}
