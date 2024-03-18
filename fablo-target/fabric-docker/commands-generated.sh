#!/usr/bin/env bash

generateArtifacts() {
  printHeadline "Generating basic configs" "U1F913"

  printItalics "Generating crypto material for Orderer" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-orderer.yaml" "peerOrganizations/orderer.org" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Org1" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-org1.yaml" "peerOrganizations/org1.co" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Org2" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-org2.yaml" "peerOrganizations/org2.ac" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating genesis block for group authorities" "U1F3E0"
  genesisBlockCreate "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config" "AuthoritiesGenesis"

  # Create directory for chaincode packages to avoid permission errors on linux
  mkdir -p "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"
}

startNetwork() {
  printHeadline "Starting network" "U1F680"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose up -d)
  sleep 4
}

generateChannelsArtifacts() {
  printHeadline "Generating config for 'ch1'" "U1F913"
  createChannelTx "ch1" "$FABLO_NETWORK_ROOT/fabric-config" "Ch1" "$FABLO_NETWORK_ROOT/fabric-config/config"
}

installChannels() {
  printHeadline "Creating 'ch1' on Org1/peer0" "U1F63B"
  docker exec -i cli.org1.co bash -c "source scripts/channel_fns.sh; createChannelAndJoin 'ch1' 'Org1MSP' 'peer0.org1.co:7041' 'crypto/users/Admin@org1.co/msp' 'orderer0.authorities.orderer.org:7030';"

  printItalics "Joining 'ch1' on  Org2/peer0" "U1F638"
  docker exec -i cli.org2.ac bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'ch1' 'Org2MSP' 'peer0.org2.ac:7061' 'crypto/users/Admin@org2.ac/msp' 'orderer0.authorities.orderer.org:7030';"
}

installChaincodes() {
  if [ -n "$(ls "$CHAINCODES_BASE_DIR/private-data-chaincode")" ]; then
    printHeadline "Approving 'private-data' for Org1 (dev mode)" "U1F60E"
    chaincodeApprove "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "1.0" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
    printHeadline "Approving 'private-data' for Org2 (dev mode)" "U1F60E"
    chaincodeApprove "cli.org2.ac" "peer0.org2.ac:7061" "ch1" "private-data" "1.0" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
    printItalics "Committing chaincode 'private-data' on channel 'ch1' as 'Org1' (dev mode)" "U1F618"
    chaincodeCommit "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "1.0" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "peer0.org1.co:7041,peer0.org2.ac:7061" "" "collections/private-data.json"
  else
    echo "Warning! Skipping chaincode 'private-data' installation. Chaincode directory is empty."
    echo "Looked in dir: '$CHAINCODES_BASE_DIR/private-data-chaincode'"
  fi

}

installChaincode() {
  local chaincodeName="$1"
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  local version="$2"
  if [ -z "$version" ]; then
    echo "Error: chaincode version is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "private-data" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/private-data-chaincode")" ]; then
      printHeadline "Packaging chaincode 'private-data'" "U1F60E"
      chaincodeBuild "private-data" "java" "$CHAINCODES_BASE_DIR/private-data-chaincode" "16"
      chaincodePackage "cli.org1.co" "peer0.org1.co:7041" "private-data" "$version" "java" printHeadline "Installing 'private-data' for Org1" "U1F60E"
      chaincodeInstall "cli.org1.co" "peer0.org1.co:7041" "private-data" "$version" ""
      chaincodeApprove "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "$version" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
      printHeadline "Installing 'private-data' for Org2" "U1F60E"
      chaincodeInstall "cli.org2.ac" "peer0.org2.ac:7061" "private-data" "$version" ""
      chaincodeApprove "cli.org2.ac" "peer0.org2.ac:7061" "ch1" "private-data" "$version" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
      printItalics "Committing chaincode 'private-data' on channel 'ch1' as 'Org1'" "U1F618"
      chaincodeCommit "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "$version" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "peer0.org1.co:7041,peer0.org2.ac:7061" "" "collections/private-data.json"

    else
      echo "Warning! Skipping chaincode 'private-data' install. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/private-data-chaincode'"
    fi
  fi
}

runDevModeChaincode() {
  local chaincodeName=$1
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "private-data" ]; then
    local version="1.0"
    printHeadline "Approving 'private-data' for Org1 (dev mode)" "U1F60E"
    chaincodeApprove "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "1.0" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
    printHeadline "Approving 'private-data' for Org2 (dev mode)" "U1F60E"
    chaincodeApprove "cli.org2.ac" "peer0.org2.ac:7061" "ch1" "private-data" "1.0" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
    printItalics "Committing chaincode 'private-data' on channel 'ch1' as 'Org1' (dev mode)" "U1F618"
    chaincodeCommit "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "1.0" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "peer0.org1.co:7041,peer0.org2.ac:7061" "" "collections/private-data.json"

  fi
}

upgradeChaincode() {
  local chaincodeName="$1"
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  local version="$2"
  if [ -z "$version" ]; then
    echo "Error: chaincode version is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "private-data" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/private-data-chaincode")" ]; then
      printHeadline "Packaging chaincode 'private-data'" "U1F60E"
      chaincodeBuild "private-data" "java" "$CHAINCODES_BASE_DIR/private-data-chaincode" "16"
      chaincodePackage "cli.org1.co" "peer0.org1.co:7041" "private-data" "$version" "java" printHeadline "Installing 'private-data' for Org1" "U1F60E"
      chaincodeInstall "cli.org1.co" "peer0.org1.co:7041" "private-data" "$version" ""
      chaincodeApprove "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "$version" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
      printHeadline "Installing 'private-data' for Org2" "U1F60E"
      chaincodeInstall "cli.org2.ac" "peer0.org2.ac:7061" "private-data" "$version" ""
      chaincodeApprove "cli.org2.ac" "peer0.org2.ac:7061" "ch1" "private-data" "$version" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "collections/private-data.json"
      printItalics "Committing chaincode 'private-data' on channel 'ch1' as 'Org1'" "U1F618"
      chaincodeCommit "cli.org1.co" "peer0.org1.co:7041" "ch1" "private-data" "$version" "orderer0.authorities.orderer.org:7030" "OR('Org1MSP.member', 'Org2MSP.member')" "false" "" "peer0.org1.co:7041,peer0.org2.ac:7061" "" "collections/private-data.json"

    else
      echo "Warning! Skipping chaincode 'private-data' upgrade. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/private-data-chaincode'"
    fi
  fi
}

notifyOrgsAboutChannels() {
  printHeadline "Creating new channel config blocks" "U1F537"
  createNewChannelUpdateTx "ch1" "Org1MSP" "Ch1" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "ch1" "Org2MSP" "Ch1" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"

  printHeadline "Notyfing orgs about channels" "U1F4E2"
  notifyOrgAboutNewChannel "ch1" "Org1MSP" "cli.org1.co" "peer0.org1.co" "orderer0.authorities.orderer.org:7030"
  notifyOrgAboutNewChannel "ch1" "Org2MSP" "cli.org2.ac" "peer0.org2.ac" "orderer0.authorities.orderer.org:7030"

  printHeadline "Deleting new channel config blocks" "U1F52A"
  deleteNewChannelUpdateTx "ch1" "Org1MSP" "cli.org1.co"
  deleteNewChannelUpdateTx "ch1" "Org2MSP" "cli.org2.ac"
}

printStartSuccessInfo() {
  printHeadline "Done! Enjoy your fresh network" "U1F984"
  echo "It has peerDevMode enabled, so remember to start your chaincodes manually."
}

stopNetwork() {
  printHeadline "Stopping network" "U1F68F"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose stop)
  sleep 4
}

networkDown() {
  printHeadline "Destroying network" "U1F916"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose down)

  printf "Removing chaincode containers & images... \U1F5D1 \n"
  for container in $(docker ps -a | grep "dev-peer0.org1.co-private-data" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.org1.co-private-data*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.org2.ac-private-data" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.org2.ac-private-data*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done

  printf "Removing generated configs... \U1F5D1 \n"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/crypto-config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"

  printHeadline "Done! Network was purged" "U1F5D1"
}
