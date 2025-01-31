#!/bin/bash

# Download and install Istio version 1.24.2 for x86_64 architecture
# curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.24.2 TARGET_ARCH=x86_64 sh -

# Change directory to the Istio installation directory
cd istio-1.24.2

# Add Istio's bin directory to the system PATH
export PATH=$PATH:$PWD/bin

# Install Istio with the default profile
istioctl install --set profile=default

# Enable automatic sidecar injection for the default namespace
kubectl label namespace default istio-injection=enabled

# Verify the installation
kubectl get all -n istio-system

