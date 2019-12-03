

az extension add azure-devops
az devops configure -d organization=https://dev.azure.com/collectorbank/
az devops configure -d project="Common Infrastructure"


az account set -s "Collector - Common Infrastructure"