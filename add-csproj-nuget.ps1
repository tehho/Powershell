param(
  [string] $filePath,
  [string[]] $InputValue = @()
)

$output = @{}
if ((Test-Path $filePath))
{
  $content = Get-Content -Path $filePath
  ($content | ConvertFrom-Json).PSobject.properties | ForEach-Object { $output.Add($_.Name, $_.Value) }
}

$output | gm

foreach ($include in $InputValue) 
{
  $rows = $include.Split(",")
  if ($rows.Count -eq 1)
  {
    $name = $rows[0]
    $version = "null"
  } 
  else 
  {
    $name = $rows[0]
    $version = $rows | Where-Object {$_ -match "version" }
    $version = $version.substring($version.IndexOf("=") + 1) 
  }

  if ($output.ContainsKey($name))
  {
    $arr = $output[$name]
    $arr += $version
    $output[$name] = @($arr | Sort-Object -Unique)
  }
  else {
    $output.Add($name, @($version))
  }
}
$test = [ordered]@{}
$output.GetEnumerator() | Where-Object {$_.Value -ne "null"} | ForEach-Object {$test.Add($_.Name, $_.Value)}

$test | ConvertTo-Json -Depth 4 | Out-File -FilePath "$filePath.json"