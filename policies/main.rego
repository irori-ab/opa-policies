package main

import data.policies.azure
import data.policies.gcp
import data.policies.labels_or_tags

# add to this list extra policies that need to be enforced
deny_rulesets := [
	labels_or_tags.deny, azure.resource_group_renaming.deny, gcp.project_renaming.deny,
]

deny contains violation if {
	some rules in deny_rulesets
	some violation in rules
}
