#!/bin/bash

if [ -z $1 ]
then
  printf "Usage (quotes required): \n\n\t./gen-cer.sh <service name (ex. NGINX)> <SAN (ex. \"DNS:example.com,DNS:*.example.com\")>\n\n"
  exit 0
fi

printf "Ensure that the environment variables \$O and \$OU have been set in your environment\n"

# Required
domain=$1
san=$2

# Company details environment variables
O=$O
OU=$OU

printf "Generating key request for $domain with SAN $san\n"

# Generate a key
openssl genrsa -out $domain.key 

# Create the request
printf "Creating CSR\n"
openssl req \
    -new \
    -key $domain.key \
    -out $domain.csr \
    -subj "/O=$O/OU=$OU/CN=$domain" \
    -addext "subjectAltName=$san" 

printf "---------------------------\n"
printf "-----Below is your CSR-----\n"
printf "---------------------------\n"
cat $domain.csr

printf "---------------------------\n"
printf "-----Below is your Key-----\n"
printf "---------------------------\n"
cat $domain.key

