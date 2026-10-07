.PHONY: test fmt check

# Run local OPA unit tests
test:
	opa test ./policies -v

# Format all Rego files
fmt:
	opa fmt -w ./policies

# Check Rego syntax validity
check:
	opa check ./policies
