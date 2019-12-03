param()

az aks get-credentials -n aks-commoninfra-linux-prod -g Group-Common-Infra-AKS --subscription "Collector - Common Infrastructure"
az aks get-credentials -n aks-commoninfra-linux-staging -g Group-Common-Infra-AKS --subscription "Collector - Common Infrastructure"
az aks get-credentials -n aks-commoninfra-internal-02 -g Group-Common-Infra-AKS --subscription "Collector - Common Infrastructure"
az aks get-credentials -n aks-commoninfra-01-test -g Group-Commoninfra-AKS --subscription "Collector - Common Infrastructure - DEV/TEST"
az aks get-credentials -n aks-commoninfra-02-test -g Group-Commoninfra-AKS --subscription "Collector - Common Infrastructure - DEV/TEST"


kubectl config delete-context prod
kubectl config delete-context staging
kubectl config delete-context internal-02 
kubectl config delete-context test-01
kubectl config delete-context test-02

kubectl config rename-context aks-commoninfra-linux-prod prod
kubectl config rename-context aks-commoninfra-linux-staging staging
kubectl config rename-context aks-commoninfra-internal-02 internal-02
kubectl config rename-context aks-commoninfra-01-test test-01
kubectl config rename-context aks-commoninfra-02-test test-02