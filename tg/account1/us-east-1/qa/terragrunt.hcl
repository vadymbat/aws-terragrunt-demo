terraform {}

locals {
  input_var_map = merge(
    yamldecode(
      file(find_in_parent_folders("account_vars.yaml"))
    ),
    yamldecode(
      file(find_in_parent_folders("region_vars.yaml"))
    ),
    yamldecode(
      file("env_vars.yaml")
    )
  )


  common_tags = {
    "env"     = local.input_var_map.env
    "project" = local.input_var_map.project_name
  }

  resource_prefix = join("-",
    [
      local.input_var_map.account_name,
      local.input_var_map.project_name,
      local.input_var_map.region_abbreviation,
      local.input_var_map.env,
    ]
  )


  remote_state_config = {
    backend = "s3"
    config = {
      bucket              = "${local.resource_prefix}-tfstates"
      s3_bucket_tags      = local.common_tags
      key                 = "${path_relative_to_include()}/terraform.tfstate"
      region              = local.input_var_map.aws_region
      encrypt             = true
      dynamodb_table      = "${local.resource_prefix}-tf-locks"
      dynamodb_table_tags = local.common_tags
      role_arn            = local.input_var_map.acess_role
    }
  }
}

remote_state {
  backend = local.remote_state_config.backend
  config  = local.remote_state_config.config
}

inputs = {
  inputs_remote_state_config = local.remote_state_config
  common_tags                = local.common_tags
}
