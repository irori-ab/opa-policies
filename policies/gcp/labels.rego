package terraform.policies.gcp.labels

import data.terraform.policies.gcp.utils
import future.keywords.in

required_labels := {"env_owner"}

resource_changes := input.resource_changes

deny contains msg if {
	some resource in resource_changes
	utils.is_gcp_resource(resource)

	resource.change.actions[_] != "delete"
    # test
	labels := object.get(resource.change.after, "labels", {})

	missing := required_labels - object.keys(labels)

	count(missing) > 0
	msg := sprintf("GCP Resource '%s' (%s) is missing required labels: %v", [
		resource.address,
		resource.type,
		missing,
	])
}
