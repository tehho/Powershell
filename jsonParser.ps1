Param(
    )

$file = $args[0]

if (-not (Test-Path $file))
{
    Write-Host "File does not exist: $file"
    exit 1
}

Write-Host "Getting content from: $file"

$content = Get-Content -Path $file -Raw
#Write-Host $content
$json = ConvertFrom-Json $content

foreach ($element in $json)
{
    $element.Username = $element.Username.ToLower()
}

$data = ConvertTo-Json $json
Out-File -FilePath "test.json" -InputObject $data

Write-Host "Done"