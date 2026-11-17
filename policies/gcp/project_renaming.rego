package policies.gcp.project_renaming

# Deny when an existing GCP project name is changed
deny contains violation if {
	some resource in input.resource_changes
	resource.type == "google_project"

	resource.change.actions == ["update"]

	before := resource.change.before
	after := resource.change.after

	before.name != after.name

	violation := {
		"msg": sprintf(
			"GCP project name cannot be changed: %s",
			[resource.address],
		),
	}
}

# Deny when an existing GCP project ID is changed
deny contains violation if {
	some resource in input.resource_changes
	resource.type == "google_project"

	resource.change.actions == ["update"]

	before := resource.change.before
	after := resource.change.after

	before.project_id != after.project_id

	violation := {
		"msg": sprintf(
			"GCP project ID cannot be changed: %s",
			[resource.address],
		),
	}
}

# Deny any GCP project replacement
deny contains violation if {
	some resource in input.resource_changes
	resource.type == "google_project"

	resource.change.actions in [
		["delete", "create"],
		["create", "delete"],
	]

	violation := {
		"msg": sprintf(
			"Replacing GCP project is not allowed: %s",
			[resource.address],
		),
	}
}
