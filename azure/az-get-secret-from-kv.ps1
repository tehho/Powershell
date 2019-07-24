param(
  [string]
  [alias("kv")] $keyvault
)

$data = az keyvault secret list --vault-name kv-azdo-curity-dev -o json | convertfrom-json 
$secrets = $data | ForEach-Object { $_.id -replace "(https.*\/)",""}

return $secrets