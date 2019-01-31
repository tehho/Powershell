Param(
    )

if ($args[0] -eq "--list")
{
    kubectl get namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty metadata | Select-Object -ExpandProperty name
    exit 0
}

kubectl config set-context $(kubectl config current-context) --namespace="$($args[0])"
kubectl get pods