param(

)

$pods = kubectl get pods --all-namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty items

foreach ($pod in $pods)
{
  $containers = $pod.spec.containers
  
  foreach ($container in $containers)
  {
    $print = $null -ne $container.resources.limits
    
    $containerName = $container.name
    $containerResources = $container.resources.limits

    if ($print)
    {
      Write-Host "Name: $containerName"
      Write-Host "Limits: $containerResources"
    }
    
  }
}
