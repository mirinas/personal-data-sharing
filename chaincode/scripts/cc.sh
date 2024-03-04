#!/usr/bin/bash
cd $CHAINCODE_DIR/target
java -jar chaincode.jar -i "private-data:1.0" --peerAddress 10.0.2.15:7052
