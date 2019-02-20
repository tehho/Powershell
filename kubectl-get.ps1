param(
  [string] 
  [alias("r")]$resource = "pod",
  [string] 
  [alias("n")]$namespace = "kube-system"
)

kubectl get $resource -n $namespace -o json | ConvertFrom-Json | Select-Object -ExpandProperty item