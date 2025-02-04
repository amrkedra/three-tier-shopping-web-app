#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami

helm install my-rabbitmq bitnami/rabbitmq --version 15.2.3


# OR can use the following command to install the chart with offical k8s file

# kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
# namespace/rabbitmq-system created
# customresourcedefinition.apiextensions.k8s.io/rabbitmqclusters.rabbitmq.com created
# serviceaccount/rabbitmq-cluster-operator created
# role.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-role created
# clusterrole.rbac.authorization.k8s.io/rabbitmq-cluster-operator-role created
# rolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-rolebinding created
# clusterrolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-operator-rolebinding created
# deployment.apps/rabbitmq-cluster-operator created


# Or can be installed as standalone server

# sudo apt-get install curl gnupg apt-transport-https -y

# ## Team RabbitMQ's main signing key
# curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
# ## Community mirror of Cloudsmith: modern Erlang repository
# curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-erlang.E495BB49CC4BBE5B.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg > /dev/null
# ## Community mirror of Cloudsmith: RabbitMQ repository
# curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-server.9F4587F226208342.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.9F4587F226208342.gpg > /dev/null

# ## Add apt repositories maintained by Team RabbitMQ
# sudo tee /etc/apt/sources.list.d/rabbitmq.list <<EOF

## Update package indices
# sudo apt-get update -y

# ## Install Erlang packages
# sudo apt-get install -y erlang-base \
#                         erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
#                         erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
#                         erlang-runtime-tools erlang-snmp erlang-ssl \
#                         erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

# ## Install rabbitmq-server and its dependencies
# sudo apt-get install rabbitmq-server -y --fix-missing


# Credentials:
#     echo "Username      : user"
#     echo "Password      : $(kubectl get secret --namespace default my-rabbitmq -o jsonpath="{.data.rabbitmq-password}" | base64 -d)"
#     echo "ErLang Cookie : $(kubectl get secret --namespace default my-rabbitmq -o jsonpath="{.data.rabbitmq-erlang-cookie}" | base64 -d)"
