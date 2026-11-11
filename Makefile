.PHONY: test unit-test fmt check

# Run conftest integration tests
test:
	conftest test --strict -p policies  testcases/
   
# Run local OPA unit tests
unit-test:
	opa test ./policies -v

# Format all Rego files
fmt:
	opa fmt -w ./policies

# Check Rego syntax validity
check:
	opa check --strict ./policies
