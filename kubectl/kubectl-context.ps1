Param(
    )

if ($args.Count -eq 0)
{
    kubectl config view -o json | ConvertFrom-Json | Select-Object -ExpandProperty "current-context"
    exit 0
}

if ($args[0] -eq "--list")
{
    kubectl config view -o json | ConvertFrom-Json | Select-Object -ExpandProperty Contexts | Select-Object -ExpandProperty name
    exit 0
}

kubectl config use-context $args[0]

$jobs = Get-Job | Where-Object {$_.Name.StartsWith("kubectl-proxy")} | Select-Object -ExpandProperty Id
$jobs | ForEach-Object { remove-job -InstanceId $_ -Force }
#kubectl proxy
$job = Start-Job -Name "kubectl-proxy" -ScriptBlock {kubectl proxy}