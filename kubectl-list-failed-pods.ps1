Param(
)

$namespaces = kubectl get namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty metadata | Select-Object -ExpandProperty name
$namespaces

foreach ($namespace in $namespaces)
{
  $namespace
  
  $pods = kubectl get pods -n $namespace --field-selector status.phase=Failed -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty metadata | Select-Object -ExpandProperty name
  $pods

  $filepath = "kubectl-failed-pods-$namespace.log"
  
  foreach ($pod in $pods)
  {
    Out-File -FilePath $filepath -Append -InputObject $pod
  }
}