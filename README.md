## Getting Started

1. Check OPA's getting started guide (https://github.com/open-policy-agent/opa#get-started-with-opa) and how to integrate OPA with Terraform (https://developer.hashicorp.com/terraform/cloud-docs/policy-enforcement/define-policies/opa#define-open-policy-agent-policies-for-hcp-terraform)
2. Install OPA's CLI on your local machine
3. Install Conftest's CLI on your local machine

## Directory structure


```
├── fixtures
│   └── *.json
└── policies
    ├── aws/
    │   ├── *.rego
    │   └── *_test.rego
    ├── azure/
    │   ├── *.rego
    │   └── *_test.rego
    ├── gcp/
    │   ├── *.rego
    │   └── *_test.rego
    ├── *.rego
    ├── *_test.rego
    └── main.rego

```

Policies that must apply for all cloud providers live under `policies` and cloud especific policies live under dedicated directories.

The `fixtures/` directory contains sample Terraform plan outputs and other files used for integration testing.
`main.rego` is the entrypoint for running OPA against input files. It contains a list of all existing rules.
 
## Testing

* Run `make check` for checking policies
* Run `make unit-test` for running unit tests
* Run `make test` for running integration tests against the `fixtures/` dir.

## Formatting

Before commiting, make sure that the policies are formatted by running `make fmt`
