Param(
    [string] $namespace = "",
    [string] $pod,
    [string] $infile,
    [string] $outfile
    )

if ($namespace -eq "")
{
    $config = kubectl config view -o json | ConvertFrom-Json
    $contexts = $config | Select-Object -ExpandProperty contexts
    $currentContextName = kubectl config current-context
    $currentContext = $contexts | Where-Object { $_.name -eq $currentContextName }
    $namespace = $currentContext | Select-Object -ExpandProperty context | Select-Object -ExpandProperty namespace
}

$podData="$namespace" + "/" + "$pod" + ":" + "$outfile"

kubectl cp $infile $podData 
kubectl exec -n $namespace $pod chmod 777 $outfile
kubectl exec -n $namespace $pod sed -i 's/\r//' $outfile