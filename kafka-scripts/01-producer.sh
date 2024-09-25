#!/bin/bash
###########################################################################
# Example producer script for Kafka and HCP Vault API
# Running Locally - Setup first VAULT_ADDR and VAULT_TOKEN env vars
# Install Kafka using Brew or apt
###########################################################################
#Setup Vault Tokens
unset VAULT_TOKEN
export VAULT_TOKEN=$(terraform output -json kafka-encrypt-token | jq -r )


# Encode plaintext with base64
text="Plain text message"
echo $msg
plaintext_msg=$(echo ${text} | base64)
echo $plaintext_msg

json_plain=$(jq -n --arg pt "$plaintext_msg" '{"plaintext": $pt}')

# echo message b64 encrypted
echo $json_plain

encrypted_msg=$(curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --header "X-Vault-Namespace: admin" \
    --request POST \
    --data $json_plain \
    $VAULT_ADDR/v1/transit/encrypt/kafka  | jq -r .data.ciphertext)

echo $encrypted_msg

echo $encrypted_msg | \
    kafka-console-producer \
    --broker-list localhost:9092 \
    --topic vault-transit 2>/dev/null