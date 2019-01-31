Param(
    [string] $n = "",
    [string] $pod
    )

kubectl exec -it $pod "/bin/bash"