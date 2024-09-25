# Vault Auth method for kafka config - Encrypt and Decrypt
resource "vault_token_auth_backend_role" "kafka-encrypt" {
  role_name              = "kafka-encrypt"
  allowed_policies       = ["kafka-encrypt"]
  orphan                 = true
  token_period           = "86400"
  renewable              = true
  token_explicit_max_ttl = "115200"
  path_suffix            = "kafta-en"
}

resource "vault_token_auth_backend_role" "kafka-decrypt" {
  role_name              = "kafka-decrypt"
  allowed_policies       = ["kafka-decrypt"]
  orphan                 = true
  token_period           = "86400"
  renewable              = true
  token_explicit_max_ttl = "115200"
  path_suffix            = "kafka-de"
}


# Vault Transit Secrets Engine config
resource "vault_mount" "transit" {
  path                      = "transit"
  type                      = "transit"
  description               = "Kafka Encryption backend"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "key" {
  backend = vault_mount.transit.path
  name    = "kafka"
}

# Vault policies for kafka config - Encrypt and Decrypt


resource "vault_policy" "kafka-encrypt" {
  name = "kafka-encrypt"

  policy = <<EOT
# Encrypt data with 'kafka' key
path "transit/encrypt/kafka" {
  capabilities = ["update"]
}

# Read and list keys under transit secrets engine 
path "transit/*" {
  capabilities = ["read", "list"]
}

# List enabled secrets engines
path "secret/metadata/*" {
   capabilities = ["list"]
}
EOT
}


resource "vault_policy" "kafka-decrypt" {
  name = "kafka-decrypt"

  policy = <<EOT
# Decrypt data with 'kafka' key
path "transit/decrypt/kafka" {
  capabilities = ["update"]
}

# Read and list keys under transit secrets engine 
path "transit/*" {
  capabilities = ["read", "list"]
}

# List enabled secrets engines
path "secret/metadata/*" {
   capabilities = ["list"]
}
EOT
}

# Creates two Vault tokens for encrypt and decrypt - will output them in plain text

resource "vault_token" "kafka-encrypt" {
  role_name = vault_token_auth_backend_role.kafka-encrypt.role_name
  policies = [vault_policy.kafka-encrypt.id]
  renewable = true
  ttl = "24h"

  renew_min_lease = 43200
  renew_increment = 86400

  metadata = {
    "purpose" = "kafka-encrypt"
  }
}

resource "vault_token" "kafka-decrypt" {
  role_name = vault_token_auth_backend_role.kafka-decrypt.role_name

policies =[vault_policy.kafka-decrypt.id]
  renewable = true
  ttl = "24h"

  renew_min_lease = 43200
  renew_increment = 86400

  metadata = {
    "purpose" = "kafka-decrypt"
  }
}