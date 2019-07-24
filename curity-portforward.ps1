param()

$pod = kubectl get pods -l app=curity,role=admin -o json | ConvertFrom-Json | Select-Object -ExpandProperty items

Write-Host $pod
kubectl port-forward "pod/$($pod.metadata.name)" 44321:6749