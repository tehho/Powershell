Param(
    [string]$value,
    [string]$mode = "encode"
    )
$ret = ""
if ($mode -eq "encode")
{
    $Bytes = [System.Text.Encoding]::UTF8.GetBytes($value)
    $ret =[Convert]::ToBase64String($Bytes)
}
else
{
    $EncodedText = [Convert]::FromBase64String($value)
    $ret = [System.Text.Encoding]::UTF8.GetString($EncodedText)
}
return $ret
