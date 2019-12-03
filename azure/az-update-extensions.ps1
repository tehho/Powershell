param()

az extension add azure-devops

az extension list -o json | jq '.[].name' | az extension update --name $_