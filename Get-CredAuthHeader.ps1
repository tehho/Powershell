param (
  [string] $username,
  [securestring] $password
)

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))

$basic = "Basic $base64AuthInfo"

$header = @{}
$header.Add("Authorization", $basic)

return $header