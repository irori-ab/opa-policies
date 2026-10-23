package terraform.policies.utils

is_cloud_resource(resource) if {
	is_resource(resource, "azurerm_")
}

is_cloud_resource(resource) if {
	is_resource(resource, "aws_")
}

is_cloud_resource(resource) if {
	is_resource(resource, "google_")
}

is_resource(resource, type) if {
	startswith(resource.type, type)
}

resource_supports_tags_or_labels(resource) if {
	is_resource(resource, "azurerm_")
	is_object(resource.change.after)
	"tags" in object.keys(resource.change.after)
}

resource_supports_tags_or_labels(resource) if {
	is_resource(resource, "google_")
	is_object(resource.change.after)
	"labels" in object.keys(resource.change.after)
}

resource_supports_tags_or_labels(resource) if {
	is_resource(resource, "aws_")
	is_object(resource.change.after)
	"tags" in object.keys(resource.change.after)
}
