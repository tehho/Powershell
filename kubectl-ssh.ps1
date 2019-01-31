Param(
  [string]$sshKey = "$ENV:USERPROFILE/.ssh/id_akskey",
  [string]$podname = "aks-ssh"
)

$sshKey = $sshKey -replace "^C:", ""

Write-Host "Starting busybox for ssh"
"apiVersion: v1`r`nkind: Pod`r`nmetadata:`r`n  name: $podname`r`n  labels:`r`n    app: $podname`r`nspec:`r`n  containers:`r`n  - name: busybox`r`n    image: debian`r`n    args:`r`n    - sleep`r`n    - '1000000'" | kubectl create -f -

$count = 0;

do {
  $count = kubectl get pods -l app=aks-ssh -o json | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty status | Where-Object { $_.phase -eq "Pending" } | Measure-Object
  $count
}
while ($count.count -ne 0)

Start-Sleep -Seconds 5


kubectl exec $podname mkdir /root/.ssh

$podrsa = "$($podname):/root/.ssh/id_rsa"
kubectl cp $sshKey $podrsa

kubectl exec $podname chmod 0600 /root/.ssh/id_rsa
kubectl exec $podname apt-get update
kubectl exec $podname -- bash -c 'apt-get install -y openssh-client'

kubectl-list-nodes

kubectl exec -it $podname /bin/bash

# kubectl delete pods aks-ssh