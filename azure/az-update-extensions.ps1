param()

az extension list -o json | jq '.[].name' | az extension update --name $_