Param(
    )

$configFile = $env:USERPROFILE + "\.kube\"
$destinationFile = $configFile + "config"

if ($args.count -eq 0 -or $args[0] -eq "--list")
{
    Get-ChildItem -Path $configFile | Where-Object {$_.name -match "\.config" }
    exit 0
}
$configFile = $configFile + $args[0]

Copy-Item -Path $configFile -Destination $destinationFile

$data = kubectl config view -o json | ConvertFrom-Json 
$contexts = $data.contexts

if ($args.count -eq 1 -or $args[1] -eq "--list")
{
    foreach ($context in $contexts)
    {
        Write-Host "$($context.name)"
    }
    exit 0   
}

$currentContext = $args[1]

$test = $false
foreach ($context in $contexts)
{
    if ($context.name -match $currentContext)
    {
        $test = $true
    }
}

if ($test -eq $true)
{
    kubectl-context "$currentContext"
}
else 
{
    Write-Host "No match for $currentContext in $configFile"
} 