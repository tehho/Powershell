param(
  [string]
  [alias("rg")] $resourcegroup,
  [string]
  [alias("o")] $object,
  [string]
  [alias("r")] $role = "contributor"
)

$groups = az group list -o json | ConvertFrom-Json
$groups = $groups | Where-Object { ($_.name -match "$resourcegroup") }

foreach ($group in $groups) {
  $groupname = $group.name
  az role assignment create --role "$role" --assignee-object-id "$object" --resource-group $groupname
}
