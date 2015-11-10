#!/bin/sh

if [ -e .env ]
then
  echo "Not overwriting your .env file."
else
  echo "Creating new .env file from Cloud Foundry pivotal-life environment"
  CF_COLOR=false cf env pivotal-life | sed '/Getting env variables.*/,/User-Provided:/d' | grep ':' | sed -e 's/\: */=/' | tail -n +2 > .env
fi
