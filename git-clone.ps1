Param(
  )

$site = $args[0]
Write-Host $site

git clone $site

$site -match "(\w+)$"
$folder = (Get-Item -Path '.\').FullName + "\" + $Matches[0]

Set-Location -Path $folder
