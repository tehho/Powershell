param (
  [string] $username,
  [securestring] $password
)

$basic = "Basic $(base64 $($username + ":" + $password))"

$header = @{}
$header.Add("Authorization", $basic)

return $header