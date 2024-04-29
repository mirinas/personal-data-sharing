#!/usr/bin/env bash

chaincodeList() {
  if [ "$#" -ne 2 ]; then
    echo "Expected 2 parameters for chaincode list, but got: $*"
    exit 1

  elif [ "$1" = "peer0.owners.org" ]; then

    peerChaincodeListTls "cli.owners.org" "peer0.owners.org:7021" "$2" "crypto-orderer/tlsca.owners.org-cert.pem" # Third argument is channel name

  elif
    [ "$1" = "peer0.org1.co" ]
  then

    peerChaincodeListTls "cli.org1.co" "peer0.org1.co:7041" "$2" "crypto-orderer/tlsca.owners.org-cert.pem" # Third argument is channel name

  elif
    [ "$1" = "peer0.org2.ac" ]
  then

    peerChaincodeListTls "cli.org2.ac" "peer0.org2.ac:7061" "$2" "crypto-orderer/tlsca.owners.org-cert.pem" # Third argument is channel name

  elif
    [ "$1" = "peer0.org3.gov" ]
  then

    peerChaincodeListTls "cli.org3.gov" "peer0.org3.gov:7081" "$2" "crypto-orderer/tlsca.owners.org-cert.pem" # Third argument is channel name

  else

    echo "Fail to call listChaincodes. No peer or channel found. Provided peer: $1, channel: $2"
    exit 1

  fi
}

# Function to perform chaincode invoke. Accepts 5 parameters:
#   1. comma-separated peers
#   2. channel name
#   3. chaincode name
#   4. chaincode command
#   5. transient data (optional)
chaincodeInvoke() {
  if [ "$#" -ne 4 ] && [ "$#" -ne 5 ]; then
    echo "Expected 4 or 5 parameters for chaincode list, but got: $*"
    echo "Usage: fablo chaincode invoke <peer_domains_comma_separated> <channel_name> <chaincode_name> <command> [transient]"
    exit 1
  fi
  cli=""
  peer_addresses=""

  peer_certs=""

  if [[ "$1" == *"peer0.owners.org"* ]]; then
    cli="cli.owners.org"
    peer_addresses="$peer_addresses,peer0.owners.org:7021"

    peer_certs="$peer_certs,crypto/peers/peer0.owners.org/tls/ca.crt"

  fi
  if [[ "$1" == *"peer0.org1.co"* ]]; then
    cli="cli.org1.co"
    peer_addresses="$peer_addresses,peer0.org1.co:7041"

    peer_certs="$peer_certs,crypto/peers/peer0.org1.co/tls/ca.crt"

  fi
  if [[ "$1" == *"peer0.org2.ac"* ]]; then
    cli="cli.org2.ac"
    peer_addresses="$peer_addresses,peer0.org2.ac:7061"

    peer_certs="$peer_certs,crypto/peers/peer0.org2.ac/tls/ca.crt"

  fi
  if [[ "$1" == *"peer0.org3.gov"* ]]; then
    cli="cli.org3.gov"
    peer_addresses="$peer_addresses,peer0.org3.gov:7081"

    peer_certs="$peer_certs,crypto/peers/peer0.org3.gov/tls/ca.crt"

  fi
  if [ -z "$peer_addresses" ]; then
    echo "Unknown peers: $1"
    exit 1
  fi

  if [ "$2" = "ch1" ]; then
    ca_cert="crypto-orderer/tlsca.owners.org-cert.pem"
  fi

  peerChaincodeInvokeTls "$cli" "${peer_addresses:1}" "$2" "$3" "$4" "$5" "${peer_certs:1}" "$ca_cert"

}
