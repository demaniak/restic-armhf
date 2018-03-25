#!/bin/bash
echo "Running with ID $B2_ACCOUNT_ID"
SRC=/src
PWD="/run/secrets/restic"
CMD="./restic -p $PWD"
function bucketname  {
  BUCKET_NAME=`basename $1`
  BUCKET_NAME="$B2_ACCOUNT_ID-$(echo -e "$BUCKET_NAME" | tr -dc '[:alnum:]')"
  echo $BUCKET_NAME
  return 0
}

function initbucket {
  $CMD -r b2:$1 init
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
  $CMD -r b2:$BUCKET_NAME backup $1
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
