Param(
)

if ( $args[0].Length -eq "0")
{
  Write-Host No path given;
  exit 0;
}

mkdir -Path $args[0]
cd $args[0]