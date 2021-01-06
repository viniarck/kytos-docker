#!/bin/bash
set -e

usage() {
  echo "docker run amlight/kytos [options]"
  echo "    -h, --help                    display help information"
  echo "    /path/program ARG1 .. ARGn    execute the specfified local program"
  echo "    --ARG1 .. --ARGn              execute Kytos with these arguments"
}

launch() {
  # If first argument is an absolute file path then execute that file passing
  # it the rest of the arguments
  if [[ $1 =~ ^/ ]]; then
    exec $@

  # execute kytos with all the arguments
  else
    echo "Starting kytos with: kytosd $@"
    kytosd $@
    tail -f /dev/null
  fi
}

if [ $1 == "-h" -o $1 == "--help" ]; then
  usage
  exit 0
fi

# Start syslog
service rsyslog start

launch $@
