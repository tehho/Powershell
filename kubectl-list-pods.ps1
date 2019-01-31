Param(
  [string]$namespace = ""
)

if ($namespace -ne "")
{
  if ($namespace -eq "all")
  {
    $namespace = "--all-namespaces"
  }
  else {
    $namespace = "-n $($namespace)"
  }
}

kubectl get pods $namespace -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Sort-Object -Property @{Expression = "$_.spec.nodeName"; Ascending = $true} | ForEach-Object {Write-Host "Name: $($_.metadata.name) Node: $($_.spec.nodeName)"}