#!/bin/sh

ENV_FILE=".env"
VAR_LIST="varlist"

createFromCF() {
  echo "Creating new .env file from Cloud Foundry pivotal-life environment."
  CF_COLOR=false cf env pivotal-life-staging | sed '/Getting env variables.*/,/User-Provided:/d' | grep ':' | sed -e 's/\: */=/' > $ENV_FILE
}

addFromVarlist() {
  echo "Using variables from varlist."
  cat $VAR_LIST >> $ENV_FILE
}

if [ -e $ENV_FILE ]
then
  echo "Not overwriting your .env file."
else
  if [ -e $VAR_LIST ]
  then
    createFromCF
    addFromVarlist
  else
    echo "WARNING: YOU DON'T HAVE A VAR LIST. THIS MAY BREAK YOUR APP."
    echo "Continuing anyway..."
    createFromCF
  fi
fi
