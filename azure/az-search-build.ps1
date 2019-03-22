param(
)
$name = "--list"

if ($args.Count -gt 0)
{
  $name = $args[0]
}

$builds = az pipelines build definition list -o json | ConvertFrom-Json
if ($name -ne "--list") 
{
  $builds = $builds | Where-Object {$_.name -match "$name"}
}

$builds | Select-Object -Property Name, ID

exit 0
