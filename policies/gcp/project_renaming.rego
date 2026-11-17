package policies.gcp.project_renaming

# Deny when an existing GCP project name or project ID is changed
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
