#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "org1" ] && [ "$3" = "peer0" ]; then

    peerChannelList "cli.org1.co.uk" "peer0.org1.co.uk:7041"

  elif
    [ "$1" = "list" ] && [ "$2" = "org2" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.org2.ac.uk" "peer0.org2.ac.uk:7061"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "ch1" ] && [ "$3" = "org1" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "ch1" "cli.org1.co.uk" "peer0.org1.co.uk:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "ch1" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "ch1" "cli.org1.co.uk" "$TARGET_FILE" "peer0.org1.co.uk:7041"

  elif [ "$1" = "fetch" ] && [ "$3" = "ch1" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "ch1" "cli.org1.co.uk" "${BLOCK_NAME}" "peer0.org1.co.uk:7041" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "ch1" ] && [ "$3" = "org2" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "ch1" "cli.org2.ac.uk" "peer0.org2.ac.uk:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "ch1" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "ch1" "cli.org2.ac.uk" "$TARGET_FILE" "peer0.org2.ac.uk:7061"

  elif [ "$1" = "fetch" ] && [ "$3" = "ch1" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "ch1" "cli.org2.ac.uk" "${BLOCK_NAME}" "peer0.org2.ac.uk:7061" "$TARGET_FILE"

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

}
