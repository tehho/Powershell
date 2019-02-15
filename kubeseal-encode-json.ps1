param (
  [string] $jsonFile
)

$path = ($jsonFile | Split-Path -Parent) + "/"

$fileName = (($jsonFile | Split-Path -Leaf) -replace "\.json","").ToLower() -replace "\.","-"

$secretYaml = kubectl create secret generic $fileName --from-file=$jsonFile --dry-run -o yaml

$outFile = $path + "sealed-" + $fileName + ".yml"
$secretYaml | kubeseal | ConvertFrom-Json | ConvertTo-Yaml | Out-File -FilePath $outFile