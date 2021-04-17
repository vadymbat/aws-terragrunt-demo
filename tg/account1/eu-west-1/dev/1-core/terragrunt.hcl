terraform {
  source = "git::git@github.com:vadymbat/aws-terragrunt-demo-tf-module-core.git?ref=main"
}

include {
  path = find_in_parent_folders()
}

locals{
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
    "env" = local.input_var_map.env
    "project" = local.input_var_map.project_name
    "service" = local.input_var_map.service_name
  }
}

dependencies {
  paths = ["../core"]
}

inputs = {
  aws_region = local.input_var_map.aws_region
  tags = local.common_tags
}