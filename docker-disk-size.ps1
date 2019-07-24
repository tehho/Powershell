param(
  [string] $diskSize = ""
)

net stop docker;
$process = Start-Process -FilePath "C:\Program Files\Docker\Docker\resources\dockerd.exe" -ArgumentList "--unregister-service" -Wait -NoNewWindow
if ($diskSize -eq "")
{
  $process = Start-Process -FilePath "C:\Program Files\Docker\Docker\resources\dockerd.exe" -ArgumentList @("--register-service") -Wait -NoNewWindow
}
else {
  
  $process = Start-Process -FilePath "C:\Program Files\Docker\Docker\resources\dockerd.exe" -ArgumentList @("--register-service", "--storage-opt", "size=$diskSize") -Wait -NoNewWindow
}
net start docker
