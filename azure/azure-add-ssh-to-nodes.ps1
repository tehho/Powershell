Param(
  [string]$sshFile = "$ENV:USERPROFILE/.ssh/id_key",
  [string]$nodeResourceGroup = "",
  [string]$username = "azureuser"
)

if (-not (Test-Path $sshFile))
{
  ssh-keygen -f $sshFile
}

$nodes = az vm list --resource-group $nodeResourceGroup -o json | ConvertFrom-Json | ForEach-Object { $_ | Select-Object -ExpandProperty name }

foreach ($node in $nodes) 
{
  az vm user update --resource-group $nodeResourceGroup --name $node --username $username --ssh-key-value "$sshFile.pub" --no-wait
}