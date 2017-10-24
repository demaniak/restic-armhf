#!/bin/sh
echo "Running with ID $B2_ACCOUNT_ID"
./restic -p /run/secrets/restic -r b2:testWithDocker init 
