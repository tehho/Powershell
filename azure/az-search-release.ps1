param(
)
$name = "--list"

if ($args.Count -gt 0)
{
  $name = $args[0]
}

$releases = az pipelines release definition list -o json | ConvertFrom-Json
if ($name -ne "--list") 
{
  $releases = $releases | Where-Object {$_.name -match "$name"}
}

$releases | Select-Object -Property Name, ID

exit 0
