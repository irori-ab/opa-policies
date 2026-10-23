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

is_azure_resource_without_tags(resource) if {
    startswith(resource.type, "azurerm_")
    resource.type in {
    	"azurerm_federated_identity_credential",
    	"azurerm_role_assignment"
    }
}