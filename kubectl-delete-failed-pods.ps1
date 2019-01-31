Param(
    )

$namespaces = kubectl get namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty metadata | Select-Object -ExpandProperty name

workflow delete_pod_per_namespace {
    param (
        [string[]]$namespaces
    )

    foreach -parallel ($namespace in $namespaces)
    # foreach ($namespace in $namespaces)
    {
        $pods = kubectl get pods --field-selector=status.phase=Failed -n $namespace -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty metadata | Select-Object -ExpandProperty name
        
        $chunks = @()
        for ($i = 0; $i -lt $pods.Count; $i += 10) 
        { 
            $chunks += ($pods[$i .. ($i+10)])
        }
        $chunks
        
        foreach ($chunk in $chunks)
        {
            foreach -parallel ($pod in $chunk)
            {
                kubectl delete pods $pod -n $namespace
            }
        }
    }
}

delete_pod_per_namespace -namespaces $namespaces