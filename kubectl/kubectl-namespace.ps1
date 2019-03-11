Param(
    )

if ($args.Count -eq 0)
{
    $currentContext = kubectl-context
    kubectl config view -o json | ConvertFrom-Json | Select-Object -ExpandProperty contexts | Where-Object { $_.name -eq $currentContext } | Select-Object -ExpandProperty context | Select-Object -ExpandProperty namespace
    exit 0
}

if ($args[0] -eq "--list")
{
    kubectl get namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty metadata | Select-Object -ExpandProperty name
    exit 0
}

kubectl config set-context $(kubectl config current-context) --namespace="$($args[0])"
kubectl get pods