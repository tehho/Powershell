Param(
    [string]$file
    )

Write-Host $file

if (-not (Test-Path $file))
{
    Write-Host "File does not exist"
    exit 1
}

$content = Get-Content -Path $file -Raw
$arr = $content -split "---"



foreach ($element in $arr)
{
    #Write-Host $element
    $temp = ConvertFrom-Yaml -Yaml $element

    $fileName = "test-$($temp.metadata.name)-$($temp.kind).yml"
    Write-Host $fileName
    $element | Out-File -FilePath $fileName
}

exit 0