package terraform.policies.gcp.utils

is_gcp_resource(resource) if {
	startswith(resource.type, "google_")
}
