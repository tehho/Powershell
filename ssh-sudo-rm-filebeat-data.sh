#!/bin/bash

for arg in "$@"; do
  echo "SSH to remove /var/lib/filebeat-data/regbistry in node $arg"
  ssh -oStrictHostKeyChecking=no azureuser@$arg sudo rm /var/lib/filebeat-data/registry
done