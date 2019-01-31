param(

)

$files = Get-ChildItem -Recurse -Path $PSScriptRoot | Where-Object {$_.Extension -match "csproj"}

foreach ($file in $files)
{
  $output = @()
  $fileName = $file.FullName
  $data = Get-Content -Path $fileName
  
  [xml]$xml = $data
  $project = $xml.Project
  $itemGroups = $project.ItemGroup
  
  foreach ($itemGroup in $itemGroups)
  {
    $references = $itemGroup.Reference
  
    foreach ($reference in $references)
    {
      $output += $reference.include
    } 
    
    $PackageReferences = $itemGroup.PackageReference
  
    foreach ($reference in $PackageReferences)
    {
      $temp = "$($reference.include), Version=$($reference.version)"

      $output += $temp
    } 
  }

  ./add-csproj-nuget -filePath "test.json" -InputValue $output
}
