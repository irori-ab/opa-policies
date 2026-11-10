package main

import data.policies.labels_or_tags

# add to this list extra policies that need to be enforced
deny_rulesets := [
	labels_or_tags.deny,
]

deny contains violation if {
	some rules in deny_rulesets
	some violation in rules
}
