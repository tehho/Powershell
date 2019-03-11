param()

$json = Get-Content -Path "./test.json" | ConvertFrom-Json

$ret = @{}

foreach ($field in $json.fields)
{
  $value = $field.name.Split(".")[0]

  if ($ret.ContainsKey($value))
  {
    $ret[$value] += 1
  }
  else {
    $ret.Add($value, 1)
  }
}

$ret | Sort-Object -Property Value

exit 0
