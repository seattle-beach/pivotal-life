#!/bin/sh

ENV_FILE=".env"
VAR_LIST="varlist"

createFromCF() {
  echo "Creating new .env file from Cloud Foundry pivotal-life environment."
  CF_COLOR=false cf env pivotal-life | sed '/Getting env variables.*/,/User-Provided:/d' | grep ':' | sed -e 's/\: */=/' > $ENV_FILE
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
    echo "varlist found. From which should I create the .env file? [default: 1]"
    echo
    echo "1 - from the CF pivotal-life environment, then append varlist"
    echo "2 - from varlist, ignoring variables in the CF pivotal-life environment"
    echo "3 - from the CF pivotal-life environment, ignoring varlist"
    echo
    read sel
    case $sel in
      "") createFromCF; addFromVarlist;;
      1) createFromCF; addFromVarlist;;
      2) addFromVarlist;;
      3) createFromCF;;
      *) echo "Bad value. Nothing was done, so you should re-run this script if you want an .env";;
    esac
  else
    echo "No varlist."
    createFromCF
  fi
fi
