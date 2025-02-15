#!/bin/bash

# Define tenant and workspace information
export TENANT="noema"
export WORKSPACE="noema"
export ORGANIZATION="noema"
export APPLICATION="shopping-app"

# Define the suffix for the environment (valid values: 01 or 02)
# export SUFFIX="01" # Change to 02 for the second environment

# Set Terraform variables
export TF_VAR_tenant_id="ce2ca24b-31bd-4c57-a5c0-587475ef66d4"  # Tenant ID of the environment
export TF_VAR_client_id="a833f3b2-4ace-4e92-97dc-085451cc31c1"  # Client ID for the service principal
export TF_VAR_client_secret="x4Z8Q~.On9yz6JX6Vvl.Pr_Fi9os9Ma.C0UVTcWz"  # Client secret for the service principal
export TF_VAR_subscription_id="4f0973f0-6489-428b-b166-69fd7ae16bb8" # Subscription ID

# Optional: Echo to verify setup (remove in production)
echo "TENANT: $TENANT"
echo "WORKSPACE: $WORKSPACE"
echo "ORGANIZATION: $ORGANIZATION"
echo "APPLICATION: $APPLICATION"
echo "SUFFIX: $SUFFIX"
echo "TF_VAR_tenant_id: $TF_VAR_tenant_id"
echo "TF_VAR_client_id: $TF_VAR_client_id"
echo "TF_VAR_subscription_id: $TF_VAR_subscription_id"


