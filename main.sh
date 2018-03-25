#!/bin/bash
echo "Running with ID $B2_ACCOUNT_ID"
SRC=/src
function bucketname  {
  BUCKET_NAME=`basename $1`
  BUCKET_NAME="$(echo -e "$BUCKET_NAME" | tr -dc '[:alnum:]')"
  echo $BUCKET_NAME
  return 0
}

function initbucket {
  ./restic -p /run/secrets/restic -r b2:$1 init
  return $?
}

function init {
  for d in $SRC/* ; do
    if [ -d "$d" ]; then
      echo "Directory found: $d"
      BUCKET_NAME=`bucketname $d`
      echo "Normalized bucket name: $BUCKET_NAME"
      initbucket $BUCKET_NAME
    fi
  done
}

function backup {
  BUCKET_NAME=`bucketname $1`
  echo "Backing up directory $1 to bucket $BUCKET_NAME"
}

function backups {
  for d in $SRC/* ; do
    if [ -d "$d" ]; then
      backup $d
    fi
  done
}

init
backups
