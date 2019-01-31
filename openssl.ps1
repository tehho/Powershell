param(
    [Parameter(Mandatory=$true)]
    [string] $pfx,
    [Parameter(Mandatory=$true)]
    [string] $cert,
    [Parameter(Mandatory=$true)]
    [string] $key,
    [string] $output = "pfx"
)

$openssl = "C:/Program Files/OpenSSL-Win64/bin/openssl.exe"

if ($output -eq "pfx")
{
    & $openssl pkcs12 -export -out $pfx -inkey $key -in $cert
}
else 
{
    & $openssl pkcs12 -in $pfx -nocerts -out $key
    & $openssl pkcs12 -in $pfx -clcerts -nokeys -out $cert
}
