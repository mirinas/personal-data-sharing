#!/usr/bin/bash
body='{"Function": "'$1'", "Args": ['$2']}'
sh -c "peer chaincode invoke -n private-data -C ch1 -o 127.0.0.1:7050 -c '${body}'"
