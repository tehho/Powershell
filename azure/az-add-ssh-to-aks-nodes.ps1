Param(
  [string]$sshFile = "$ENV:USERPROFILE/.ssh/id_akskey",
  [string]$aksCluster = "",
  [string]$aksClusterResourceGroup = ""
)

if ($aksCluster -eq "" -or $aksClusterResourceGroup -eq "")
{
  az aks list -o table
  exit 0;
}

if (-not (Test-Path $sshFile))
{
  ssh-keygen -f $sshFile
}

$nodeResourceGroup = az aks show --resource-group $aksClusterResourceGroup --name $aksCluster --query nodeResourceGroup -o tsv
Write-Host "Node Resource Group: $nodeResourceGroup"
$nodes = az vm list --resource-group $nodeResourceGroup -o json | ConvertFrom-Json | ForEach-Object { $_ | Select-Object -ExpandProperty name }

workflow AddSshToNodes {
  param (
    [string[]] $nodes,
    [string] $nodeResourceGroup,
    [string] $sshFile
  )

  foreach -parallel ($node in $nodes) {
    $node
    az vm user update --resource-group $nodeResourceGroup --name $node --username azureuser --ssh-key-value "$sshFile.pub"
  }
   
}

AddSshToNodes -nodes $nodes -nodeResourceGroup $nodeResourceGroup -sshFile $sshFile 


