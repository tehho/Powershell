param()

if (($args.Count -eq "0") -or ($args[0] -eq "-h" -or $args[0] -eq "--help"))
{
  Write-Host "Do kubectl commands in the background"
  Write-Host
  Write-Host "Examples:"
  Write-Host " # List all started jobs"
  Write-Host "kubectl-tasks list"
  exit 0
}

$command = $args[0]

if ($command -eq "create")
{
  $subcommand = $args[1]

  if ($subcommand -eq "port-forward")
  {
    $source = $args[2]
    $externalPort = $args[3]
    $internalPort = $args[4]

    $name = "kubectl-port-forward-$source-$externalPort-$internalPort"
    Remove-Job -Name $name
    Start-Job -Name $name -ScriptBlock {kubectl port-forward "$source" "$($internalPort):$($externalPort)"}
  }
}
elseif ($command -eq "list")
{
  $jobs = Get-Job | Where-Object {$_.Name.StartsWith("kubectl")}
  $jobs
}
elseif ($command -eq "port-forward")
{
  
}