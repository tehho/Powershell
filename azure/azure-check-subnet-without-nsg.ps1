param(

)

function GetSubnets {
  param (
    [string] $vnetName,
    [string] $resourceGroup,
    [string] $subscriptionId
  )
  
  $subnets = az network vnet subnet list --vnet-name $vnetName --resource-group $resourceGroup --subscription $subscriptionId -o json | ConvertFrom-Json

  return $subnets
}

function GetVnets {
  param (
    [string] $subscriptionId
  )
  
  $vnets = az network vnet list --subscription $subscriptionId -o json | ConvertFrom-Json

  return $vnets
}

function  GetAccounts {
  param (
    
  )

  $accounts = az account list --all -o json | ConvertFrom-Json
  
  return $accounts
}

workflow Scan-Vnets
{
  param (
    [string] $subscriptionId
  )

  $vnets = GetVnets -subscriptionId $subscriptionId

  $ret = @{}

  foreach -parallel ($vnet in $vnets)
  {
    $vnetName = $vnet.name
    $resourceGroup = $vnet.resourceGroup
    $subnets = GetSubnets -vnetName $vnetName -resourceGroup $resourceGroup -subscriptionId $subscriptionId
    $subnetNames = $subnets | Where-Object { $null -eq $_.networkSecuritygroup } | Select-Object -ExpandProperty Name
    if ($subnetNames.count -ne 0)
    {
    }
  }
}

workflow ScanAccounts {
  param (
  )


  $accounts = GetAccounts

  $ret = @{}

  foreach -parallel ($account in $accounts)
  {
    $accountId = $account.id
    $accountName = $account.name

    $accountData = ScanAccount -subscriptionId $accoundId

    $vnets = GetVnets -subscriptionId $accountId

    $vnetRet = @{}

    foreach ($vnet in $vnets)
    {
      $vnetName = $vnet.name
      $resourceGroup = $vnet.resourceGroup

      $subnets = GetSubnets -vnetName $vnetName -resourceGroup $resourceGroup -subscriptionId $accountId
      $subnetNames = $subnets | Where-Object { $null -eq $_.networkSecuritygroup } | Select-Object -ExpandProperty Name

      $count = $subnetNames | Measure-Object
      if ($count.count -gt 0)
      {
        $vnetRet.Add($vnetName, $subnetNames)
      }
    }

    if ($vnetRet.Count -ne 0)
    {
      $ret.Add($accountName, $vnetRet)
    }
  }
  return $ret
}

$ret = ScanAccounts

$ret | ConvertTo-Json | Out-File -FilePath "azure-subnet-without-nsg.json"


