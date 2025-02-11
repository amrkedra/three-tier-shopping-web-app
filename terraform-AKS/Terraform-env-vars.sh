#!/bin/bash

# Define tenant and workspace information
export TENANT="noema"
export WORKSPACE="noema"
export ORGANIZATION="noema"
export APPLICATION="shopping-app"

# Define the suffix for the environment (valid values: 01 or 02)
# export SUFFIX="01" # Change to 02 for the second environment

# Set Terraform variables
export TF_VAR_tenant_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # Tenant ID of the environment
export TF_VAR_client_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # Client ID for the service principal
export TF_VAR_client_secret="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # Client secret for the service principal
export TF_VAR_subscription_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Subscription ID

# Optional: Echo to verify setup (remove in production)
echo "TENANT: $TENANT"
echo "WORKSPACE: $WORKSPACE"
echo "ORGANIZATION: $ORGANIZATION"
echo "APPLICATION: $APPLICATION"
echo "SUFFIX: $SUFFIX"
echo "TF_VAR_tenant_id: $TF_VAR_tenant_id"
echo "TF_VAR_client_id: $TF_VAR_client_id"
echo "TF_VAR_subscription_id: $TF_VAR_subscription_id"


