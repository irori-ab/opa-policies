package terraform.policies.labels

import data.terraform.policies.utils
import future.keywords.in
import future.keywords.or

required_labels_or_tags := {"env_owner"}

resource_changes := input.resource_changes

deny contains msg if {
	some resource in resource_changes
	utils.is_cloud_resource(resource)

	# Resources being releted are allowed to have missing labels/tags
	not "delete" in resource.change.actions

	# GCP calls it labels
	labels := object.get(resource.change.after, "labels", {})

	# Azure and AWS call it tags
	tags := object.get(resource.change.after, "tags", {})

	missing := (required_labels_or_tags - object.keys(labels)) - object.keys(tags)

	count(missing) > 0
	msg := sprintf("Resource '%s' (%s) is missing required labels/tags: %v", [
		resource.address,
		resource.type,
		missing,
	])
}
