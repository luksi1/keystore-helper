#!/usr/bin/bash

function check_param {
  param=$1
  if [[ "${param}x" == "x" ]]; then
    echo ""
    echo "You are missing a mandatory parameter!"
    echo ""
    $0 -h
    exit 1
  fi
}

