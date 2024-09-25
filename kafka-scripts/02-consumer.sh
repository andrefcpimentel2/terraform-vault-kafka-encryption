#!/bin/bash
###########################################################################
# Example consumer script for Kafka and HCP Vault API
# Running Locally - Setup first VAULT_ADDR and VAULT_TOKEN env vars
# Install Kafka using Brew or apt
###########################################################################
#Setup Vault Tokens
unset VAULT_TOKEN
export VAULT_TOKEN=$(terraform output -json kafka-decrypt-token | jq -r )
# Setup Kafka Topic
# Consume message from Kafka topic


encrypted_msg=$(kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --max-messages 1 --from-beginning \
    --topic vault-transit 2>/dev/null)

echo $encrypted_msg

# Decrypt with Vault

data=$(jq -n \
--arg ct "$encrypted_msg" \
'{"ciphertext": $ct}')

echo $data

decrypted_msg=$(curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --header "X-Vault-Namespace: admin" \
    --request POST \
    --data $data \
    $VAULT_ADDR/v1/transit/decrypt/kafka| jq -r .data.plaintext )

# Decode plaintext with base64

echo $decrypted_msg | base64 -d