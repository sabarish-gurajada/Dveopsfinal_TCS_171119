#!/bin/bash
# Bash Menu Script Example

#Variable declaration
cd $HOME
echo "Downloading and installing Elastic search in progress"
kubectl apply -f https://download.elastic.co/downloads/eck/0.8.0/all-in-one.yaml
echo "Downloaded elastic search successfully"
sleep 2
echo " please find status of elastic search"
kubectl get pods -n elastic-system
