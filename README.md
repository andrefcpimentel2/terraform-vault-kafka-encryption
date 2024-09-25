## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_mount.transit](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.kafka-decrypt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.kafka-encrypt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_token.kafka-decrypt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token) | resource |
| [vault_token.kafka-encrypt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token) | resource |
| [vault_token_auth_backend_role.kafka-decrypt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token_auth_backend_role) | resource |
| [vault_token_auth_backend_role.kafka-encrypt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token_auth_backend_role) | resource |
| [vault_transit_secret_backend_key.key](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/transit_secret_backend_key) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kafka-decrypt-token"></a> [kafka-decrypt-token](#output\_kafka-decrypt-token) | n/a |
| <a name="output_kafka-encrypt-token"></a> [kafka-encrypt-token](#output\_kafka-encrypt-token) | n/a |
