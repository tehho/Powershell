param(
  [string] $id = $null
)

if ($null -eq $id)
{
  $id = $args[0]
}

az pipelines release create --definition-id "$id" --open

exit 0
