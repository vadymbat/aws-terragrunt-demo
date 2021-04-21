terraform {
  source = "git::git@github.com:vadymbat/aws-terragrunt-demo-tf-module-application.git?ref=main"
}

include {
  path = find_in_parent_folders()
}

locals {
  input_var_map = merge(
    yamldecode(
      file(find_in_parent_folders("account_vars.yaml"))
    ),
    yamldecode(
      file(find_in_parent_folders("region_vars.yaml"))
    ),
    yamldecode(
      file(find_in_parent_folders("env_vars.yaml"))
    ),
    yamldecode(
      file("service_vars.yaml")
    )
  )

  common_tags = {
    "env"     = local.input_var_map.env
    "project" = local.input_var_map.project_name
    "service" = local.input_var_map.service_name
  }

  resource_prefix = join("-",
    [
      local.input_var_map.account_name,
      local.input_var_map.project_name,
      local.input_var_map.region_abbreviation,
      local.input_var_map.env,
    ]
  )
}

dependencies {
  paths = ["../1-core"]
}

dependency "core" {
  config_path = "../1-core"
}


inputs = {
  aws_region                = local.input_var_map.aws_region
  aws_provider_role         = local.input_var_map.acess_role
  lambda_artifact_s3_bucket = dependency.core.outputs.artifacts_s3_bucket.bucket
  tags                      = local.common_tags
  resource_prefix           = local.resource_prefix
  service_name              = local.input_var_map.service_name
  rest_api_stage            = local.input_var_map.api_stage
}
