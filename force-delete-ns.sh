#!/bin/bash

ns=$1
if [ -z $1 ]
then
  printf "Usage: ./force-delete-ns.sh <namespace>\n"
else
  kubectl get namespace $ns -o json >tmp.json 
  vim tmp.json
  curl -k -H "Content-Type: application/json" -X PUT --data-binary @tmp.json http://127.0.0.1:8001/api/v1/namespaces/$ns/finalize
fi

