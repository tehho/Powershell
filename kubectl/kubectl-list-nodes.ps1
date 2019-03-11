Param(
  [string]$sshKey = ""
)

kubectl get nodes -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | ForEach-Object { Write-Host "Name: $($_.metadata.name) , Address: $($_.status.addresses | Where-Object { $_.type -eq 'InternalIP'} | Select-Object -ExpandProperty address )" }