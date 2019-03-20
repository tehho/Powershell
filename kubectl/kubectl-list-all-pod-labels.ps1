param()

$pods = kubectl get pods --all-namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty items

$ret = @()

foreach ($pod in $pods)
{
  $metadata = $pod.metadata
  $labels = $metadata.labels | Get-Member | Where-Object MemberType -Match "Note"

  foreach ($label in $labels)
  {
    $ret += "$($label.name)"
  }
}

$ret | Sort-Object -Unique

exit 0
