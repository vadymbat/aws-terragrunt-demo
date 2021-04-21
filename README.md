# aws-terragrunt-demo
Materials for the Terragrunt demo

This is example of how to manage terraform modules via terragrunt in multiple accounts.

Terraform modules:
- [1-core](https://github.com/vadymbat/aws-terragrunt-demo-tf-module-core)
- [2-application](https://github.com/vadymbat/aws-terragrunt-demo-tf-module-application)

The terragrunt folder structure:

    ├── ...
    └── account1
        ├── account_vars.yaml
        ├── ...
        └── us-east-1
            ├── dev
            │   ├── 1-core
            │   │   ├── service_vars.yaml
            │   │   └── terragrunt.hcl
            │   ├── 2-application
            │   │   ├── service_vars.yaml
            │   │   └── terragrunt.hcl
            │   ├── env_vars.yaml
            │   └── terragrunt.hcl
            ├── ...
            └── region_vars.yaml