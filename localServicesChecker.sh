#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
bold=$(tput bold)
normal=$(tput sgr0)

function test {
  service_name=$1
  shift
  "$@" > /dev/null
  result=$?
  if [[ $result -ne 0 ]]; then
    echo "    ${bold}${red}↓${reset}  $service_name"
  else
    echo "    ${bold}${green}↑${reset}  $service_name"
  fi
}

function curl_port_test {
  test $1 curl http://127.0.0.1:$2 --silent
}

function brew_service_test {
    test $1 brew services list | grep $1
}

brew_service_test   "postgres"                5433
curl_port_test      "serviceName"               9000
