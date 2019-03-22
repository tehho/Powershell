param(
  [string]
  [alias("b")] $build = "",
  [string]
  [alias("i")] $id = ""
)

if ($build -eq "" -and $id -eq "")
{
  $data = az pipelines build list -o json | ConvertFrom-Json
  $definitions = $data | Select-Object -ExpandProperty definition | Sort-Object -Property name -Unique
  
  foreach ($definition in $definitions)
  {
    $name = $definition.name
    $id = $definition.id

    Write-Host "Name: $name"
    Write-Host "Id: $id"
    Write-Host
  }
  exit 0
}

if ($id -eq "")
{
  $data = az pipelines build list -o json | ConvertFrom-Json
  $list = $data | Select-Object -ExpandProperty definition | Where-Object { $_.name -match $build } | Sort-Object -Property name -Unique
  $count = $list | Measure-Object

  if ($count.count -eq "1")
  {
    $id = $list[0].id
  }
  else 
  {
    $list.count

    foreach ($definition in $list)
    {
      $name = $definition.name
      $id = $definition.id
  
      Write-Host "Name: $name"
      Write-Host "Id: $id"
      Write-Host
    }
    exit 0
  }
}

$data = az pipelines build list --definition-ids "$id" -o json | ConvertFrom-Json | Sort-Object -Property id

$id = $data[0].id

do 
{
  $data = az pipelines build show --id $id -o json | ConvertFrom-Json
  $test = $data.status -ne "completed"
  
  Write-Host "Name: $($data.definition.name)"
  Write-Host "Status: $($data.status)"
  Write-Host "Result: $($data.result)"
  Write-Host "Queued: $($data.queueTime)"
  Write-Host "Started: $($data.startTime)"
  Write-Host "Finished: $($data.finishTime)"
  Write-Host
  
  if ($test)
  {
    Start-Sleep -Seconds "5"
  }

} while ($test)