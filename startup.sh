#! /bin/bash
export TF_VAR_GITHUB_PAT=$GITHUB_PAT
export TF_VAR_NEPTUNE_API_TOKEN=$NEPTUNE_API_TOKEN

terraform apply -auto-approve
