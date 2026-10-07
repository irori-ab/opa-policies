## Getting Started

1. Check OPA's getting started guide (https://github.com/open-policy-agent/opa#get-started-with-opa) and how to integrate OPA with Terraform (https://developer.hashicorp.com/terraform/cloud-docs/policy-enforcement/define-policies/opa#define-open-policy-agent-policies-for-hcp-terraform)
2. Install OPA's cli on your local machine

## Directory structure

Policies are grouped by cloud provider:

```
├── policies
│   ├── aws
│   │   ├── *.rego
│   │   └── *_test.rego
│   └─ azure
│   │   ├── *.rego
│   │   └── *_test.rego
│   └── gcp
│       ├── *.rego
│       └── *_test.rego
└── policies.hcl
```

`policies.hcl` is a special configuration file that tells Hashicorp what policies to use and what enforcement level they have


## HCP configuration

This repository is configured as a policy set under https://app.eu.terraform.io/app/Irori/settings/policy-sets

## Testing

Run `make check` for checking policies and `make test` for running unit tests

## Formatting

Before commiting, make sure that the policies are formatted by running `make fmt`
