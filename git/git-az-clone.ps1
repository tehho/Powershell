param(
  [string]
  [alias("n")] $name = "$($args[0])"
)

if ($name -eq "")
{
  az repos list
}
else 
{
  $response = az repos show --repo "$name" -o json | ConvertFrom-Json
  git-clone.ps1 "$($response.webUrl)"
}