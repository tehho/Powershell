Param(
  [string]$n = "",
  [string]$output = "stdout",
  [string]$l
)


$namespace = ""
if ($n -ne "")
{
  $namespace = "-n $n"
}

$selector = ""
if ($l -ne "")
{
  $selector = "-l "
  if (-not ($l -like "*=*"))
  {
    $selector += "app="
  }
  $selector += $l.Trim()
}

$pods = kubectl get pods $selector $namespace -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | ForEach-Object { $_.metadata.name }

workflow follow_logs {
  param (
    [string[]] $pods
  )

  foreach -parallel ($pod in $pods)
  {
    kubectl logs $pod --tail=10 --follow
  }
}

if ($output -eq "stdout")
{
  follow_logs -pods $pods | Write-Host
}
if ($output -eq "file")
{
  follow_logs -pods $pods | Out-File -FilePath "$l.log"
}