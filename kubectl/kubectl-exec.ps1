Param(
    )

if ($args.count -eq 0)
{
    Write-Host "Use kubectl-exec pod_name"
    exit 1
}

$pod = "$($args[0])"

if ($pod -eq "--help")
{
    Write-Host "Use kubectl-exec pod_name"
    exit 1
}

kubectl exec -it $pod "/bin/bash"