Param(
  )

$site = $args[0]
Write-Host $site

git clone $site

$test = $site -match "(/.+)+/(.+)\.git$"
$test

if ($test -eq $false)
{
  $test = $site -match "(/.+)+/(.+)$"
  $test
}

$folder = (Get-Item -Path '.\').FullName + "\" + $Matches[2]

Set-Location -Path $folder
code .
