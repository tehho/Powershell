param()

$pods = kubectl get pods -n commoninfra-admin -o json | ConvertFrom-Json | select-object -ExpandProperty items

foreach ($pod in $pods)
{
  $podName = $pod.metadata.name
  $containers = $pod.spec.containers
  
  foreach ($container in $containers)
  {
    $resources = $container.resources
    
    $limits = $resources.limits
    $requests = $resources.requests

    if ($null -ne $limits -or $null -ne $requests)
    {
      Write-Host "Name: $podName"
    
      if ($null -ne $limits)
      {
        Write-Host "Limits"

        $cpu = $limits.cpu
        $memory = $limits.memory
        Write-Host "Cpu: $cpu"
        Write-Host "Memory: $memory"
        Write-Host
      }
    
      if ($null -ne $requests)
      {
        Write-Host "Request"

        $cpu = $requests.cpu
        $memory = $requests.memory
        Write-Host "Cpu: $cpu"
        Write-Host "Memory: $memory"
        Write-Host
      }
    }
  }
}