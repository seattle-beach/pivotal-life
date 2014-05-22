#!/bin/sh

if [ -e .env ]
then
  echo "Not overwriting your .env file."
else
  echo "Creating new .env file from Cloud Foundry pivotal-life environment"
  CF_COLOR=false cf env pivotal-life | grep ':' | sed -e 's/\: */=/' > .env
fi
