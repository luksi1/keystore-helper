#!/bin/bash

set -e

# Colors and error functions
BOLD='\e[1m'
OKGREEN='\e[32m'
FAIL='\e[31m'
RESET='\e[0m'

function fail {
  echo -e "${BOLD}${1}: ${FAIL}FAIL${RESET}"
}

function ok {
  echo -e "${BOLD}${1}: ${OKGREEN}OK${RESET}"
}

