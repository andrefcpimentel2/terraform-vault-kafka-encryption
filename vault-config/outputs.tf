output "kafka-encrypt-token"{
  value = vault_token.kafka-encrypt.client_token
  sensitive = true
}

output "kafka-decrypt-token"{
  value = vault_token.kafka-decrypt.client_token
  sensitive = true
}