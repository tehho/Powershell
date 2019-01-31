param(
  [string] $url,
  [string] $username,
  [string] $password
)

$basic = "$($username):$($password)"
$base64 = base64 $basic

$headers = @{}
$headers.Add("Authorization", "Basic $($base64)")


do
{
  $resultRaw = Invoke-WebRequest -Uri $url -Headers $headers
    
  $resultJson = $resultRaw.content
  
  $result = $resultJson | ConvertFrom-Json
  
  $values = $result.values
  
  $gitDest = Join-Path $PSScriptRoot "git"
  
  if ((Test-Path $gitDest))
  {
    remove-item -Force -Recurse -Confirm:$false $gitDest
  }
  
  (mkdir -Path $gitDest) | Out-Null
  
  for ($i = 0; $i -lt $values.Count; $i++) {
    $value = $values[$i]
    Write-Progress -Activity "Test" -Status "Found Service $($i):$($values.Count)" -PercentComplete ($i / $values.Count * 100)
  
    $links = $value.links
    $clone = $links.clone | Where-Object { $_.name -eq "https" }
    $href = $clone.href
    $href
    
    $dev_null = (git clone $href $gitDest)
    
    csproj-package-finder.ps1
    
    remove-item -Force -Recurse -Confirm:$false $gitDest
  }
  
  $url = $result.next
}
while ("" -ne $url)