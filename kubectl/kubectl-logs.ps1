Param(
    [string]
    [alias("l")] $labels,
    [string]
    [alias("n")] $namespace = "",
    [string] 
    [alias("Path")] $outFile = "",
    [string]
    [alias("t")] $tail = "100"
    )

if ($null -eq $labels -or $labels -eq "")
{
    Write-Host "Need to specify labels"
    exit 1
}

if ($outFile -eq "")
{
    $outFile = "$labels.log";
}

$namespace = $(if ($namespace -ne "") { "-n" + $namespace } else { "" })

$pods = kubectl get pods $namespace -l $labels -o json | ConvertFrom-Json | Select-Object -ExpandProperty items

Out-File -FilePath $outFile -InputObject ""

foreach ($pod in $pods)
{
    $podName = $pod.metadata.name
    $podName
    $logs = kubectl logs $podName $namespace --tail=$tail
    $logs | Out-File -FilePath $outFile -Append
}