Param(
  )

$site = $args[0]
Write-Host $site

git clone $site

$devnull = $site -match "(/.+)+/(.+).git$"
$folder = (Get-Item -Path '.\').FullName + "\" + $Matches[2]

Set-Location -Path $folder
code .
