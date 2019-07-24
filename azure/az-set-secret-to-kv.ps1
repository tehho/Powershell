param(
  [string]
  [alias("kv")] $keyvault,
  [string]
  [alias("k")] $key,
  [string]
  [alias("v")] $value = "temp"
)

az keyvault secret set --vault-name "$keyvault" --name "$key" --value "$value"