#!/bin/sh

ENV_FILE=".env"
VAR_LIST="varlist"
RAW_ENV="rawenv.fromcf"
CF_APP_NAME="pivotal-life-staging"

createFromCF() {
  CF_COLOR=false cf env $CF_APP_NAME > $RAW_ENV
  if [ $? -eq 0 ]
  then
    echo "\nCreating new .env file from Cloud Foundry $CF_APP_NAME environment."
    cat $RAW_ENV | sed '/Getting env variables.*/,/User-Provided:/d' | grep ':' | sed -e 's/\: */=/' > $ENV_FILE
  else
    echo "\nFAILED TO GET ENV VARIABLES FROM Cloud Foundry $CF_APP_NAME ENVIRONMENT"
  fi
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
