#!/bin/bash

# Set env vars and run luigid

# Set python log level
if [ "$NAMESPACE" == "scc" ]; then
  export LOGLEVEL='WARNING'
else
  export LOGLEVEL='INFO'
fi

# set environment variables in config file
# do this because Python ConfigParser can't read env vars
perl -pi -e 's/\$\{(\w+)\}/$ENV{$1}/g' $HOME/luigi.cfg

export LUIGI_CONFIG_PATH=$HOME/luigi.cfg

# run luigi
luigid --address=0.0.0.0 --port=$SCC_LUIGI_SERVICE_PORT
