param(
  [string] $path,
  [string] $outFile = "temp.txt"
)

function Test {
  param (
    $obj,
    [string] $prefix = ""
  )
  $datatypes = $obj | Get-Member | Where-Object { $_.MemberType -eq "NoteProperty" }
  
  $output = @{}

  foreach ($datatype in $datatypes)
  {
    $devnull = $datatype.Definition -match "(^.+)\s"
    $type = $Matches[0]
    
    Write-Host "Datatype: $datatype"
    Write-Host "Type: $type"

    if ($type -match "string")
    {
      Write-Host "Matches type string: $($datatype.name)"
      Write-Host
      
      $key = $prefix + $datatype.name;
      $output.Add($key, $obj.$($datatype.name))
    }
    elseif ($type -match "Object\[\]")
    {
      Write-Host "Matches type array: $($datatype.name)"
      Write-Host 

      $key = $prefix + $datatype.name;
      $value = "[""" + ($obj.$($datatype.name) -join """, """) + """]"
      $output.Add($key, $value)
    }
    else {
      Write-Host "Recursive $($obj.$($datatype.name))"

      $tempPrefix = $prefix + $datatype.name + ":";
      $output += Test -obj $obj.$($datatype.name) -prefix $tempPrefix
    }
  }

  return $output
}

$data = Get-Content -Path $path

$json = $data | ConvertFrom-Json
$output = Test -obj $json

Out-File -FilePath $outFile
$output.getenumerator() | ForEach-Object { 
  $data = $_.key + ": " + $_.value
  $data | Out-File -Append -FilePath $outFile
}