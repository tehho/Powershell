param(
  [string] $filePath,
  [string] $outPath = ""
)



if ($outPath -eq "")
{
  $fileName = $filePath | Split-Path -Leaf
  $path = $filePath | Split-Path
  $path
  $outPath = $path + "/sealed-" + $fileName;
}
$outPath

$data = Get-Content -Path $filePath

$data | kubeseal | ConvertFrom-Json | ConvertTo-Yaml | Out-File -FilePath $outPath