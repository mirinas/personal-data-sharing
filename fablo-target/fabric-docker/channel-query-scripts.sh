#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "org1" ] && [ "$3" = "peer0" ]; then

    peerChannelListTls "cli.org1.co" "peer0.org1.co:7041" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "org2" ] && [ "$3" = "peer0" ]
  then

    peerChannelListTls "cli.org2.ac" "peer0.org2.ac:7061" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "org3" ] && [ "$3" = "peer0" ]
  then

    peerChannelListTls "cli.org3.gov" "peer0.org3.gov:7081" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "org4" ] && [ "$3" = "peer0" ]
  then

    peerChannelListTls "cli.owners.org" "peer0.owners.org:7101" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "ch1" ] && [ "$3" = "org1" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "ch1" "cli.org1.co" "peer0.org1.co:7041" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "ch1" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfigTls "ch1" "cli.org1.co" "$TARGET_FILE" "peer0.org1.co:7041" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$3" = "ch1" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlockTls "ch1" "cli.org1.co" "${BLOCK_NAME}" "peer0.org1.co:7041" "crypto-orderer/tlsca.orderer.org-cert.pem" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "ch1" ] && [ "$3" = "org2" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "ch1" "cli.org2.ac" "peer0.org2.ac:7061" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "ch1" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfigTls "ch1" "cli.org2.ac" "$TARGET_FILE" "peer0.org2.ac:7061" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$3" = "ch1" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlockTls "ch1" "cli.org2.ac" "${BLOCK_NAME}" "peer0.org2.ac:7061" "crypto-orderer/tlsca.orderer.org-cert.pem" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "ch1" ] && [ "$3" = "org3" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "ch1" "cli.org3.gov" "peer0.org3.gov:7081" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "ch1" ] && [ "$4" = "org3" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfigTls "ch1" "cli.org3.gov" "$TARGET_FILE" "peer0.org3.gov:7081" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$3" = "ch1" ] && [ "$4" = "org3" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlockTls "ch1" "cli.org3.gov" "${BLOCK_NAME}" "peer0.org3.gov:7081" "crypto-orderer/tlsca.orderer.org-cert.pem" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "ch1" ] && [ "$3" = "org4" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "ch1" "cli.owners.org" "peer0.owners.org:7101" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "ch1" ] && [ "$4" = "org4" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfigTls "ch1" "cli.owners.org" "$TARGET_FILE" "peer0.owners.org:7101" "crypto-orderer/tlsca.orderer.org-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$3" = "ch1" ] && [ "$4" = "org4" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlockTls "ch1" "cli.owners.org" "${BLOCK_NAME}" "peer0.owners.org:7101" "crypto-orderer/tlsca.orderer.org-cert.pem" "$TARGET_FILE"

  else

    echo "$@"
    echo "$1, $2, $3, $4, $5, $6, $7, $#"
    printChannelsHelp
  fi

}

printChannelsHelp() {
  echo "Channel management commands:"
  echo ""

  echo "fablo channel list org1 peer0"
  echo -e "\t List channels on 'peer0' of 'Org1'".
  echo ""

  echo "fablo channel list org2 peer0"
  echo -e "\t List channels on 'peer0' of 'Org2'".
  echo ""

  echo "fablo channel list org3 peer0"
  echo -e "\t List channels on 'peer0' of 'Org3'".
  echo ""

  echo "fablo channel list org4 peer0"
  echo -e "\t List channels on 'peer0' of 'Org4'".
  echo ""

  echo "fablo channel getinfo ch1 org1 peer0"
  echo -e "\t Get channel info on 'peer0' of 'Org1'".
  echo ""
  echo "fablo channel fetch config ch1 org1 peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Org1'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> ch1 org1 peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Org1'".
  echo ""

  echo "fablo channel getinfo ch1 org2 peer0"
  echo -e "\t Get channel info on 'peer0' of 'Org2'".
  echo ""
  echo "fablo channel fetch config ch1 org2 peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Org2'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> ch1 org2 peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Org2'".
  echo ""

  echo "fablo channel getinfo ch1 org3 peer0"
  echo -e "\t Get channel info on 'peer0' of 'Org3'".
  echo ""
  echo "fablo channel fetch config ch1 org3 peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Org3'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> ch1 org3 peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Org3'".
  echo ""

  echo "fablo channel getinfo ch1 org4 peer0"
  echo -e "\t Get channel info on 'peer0' of 'Org4'".
  echo ""
  echo "fablo channel fetch config ch1 org4 peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Org4'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> ch1 org4 peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Org4'".
  echo ""

}
