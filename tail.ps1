Param(
    [string[]] $files,
    [long] $tail=10
)

#need workflow for foreach "-parallel"
workflow tail
{
    param(
        [string[]] $files,
        [long] $tail
    )
    foreach -parallel ($file in $files)
    {
        Get-Content -Tail $tail $file -Wait
    }
}

$ProgressPreference="SilentlyContinue"
tail -files $files -tail $tail | Write-Host