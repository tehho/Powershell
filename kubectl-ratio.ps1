Param(
    )


$pods = kubectl get pods --all-namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Sort-Object @{Expression={$_.spec.nodeName}}

$dict = @{}

foreach ($pod in $pods)
{
    $nodeName = $pod.spec.nodeName
    $podName = $pod.metadata.name
    if ($dict.ContainsKey($nodeName))
    {
        $dict[$nodeName] += $podName
    }
    else {
        $dict.Add($nodeName, @($podName))
    }
    
}

foreach ($key in $dict.Keys)
{
    $values = $dict[$key]
    Write-Host "$key $($values.Count)"
}