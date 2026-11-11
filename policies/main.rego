package main

import data.policies.labels_or_tags
import data.policies.resource_group_renaming

# add to this list extra policies that need to be enforced
deny_rulesets := [
	labels_or_tags.deny, resource_group_renaming.deny,
]

deny contains violation if {
	some rules in deny_rulesets
	some violation in rules
}
