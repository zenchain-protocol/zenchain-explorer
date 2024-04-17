#!/bin/sh

unamestr=$(uname)

if [ "$unamestr" = 'Linux' ]; then
  export $(grep -v '^#' ./docker-compose/envs/common-backend.env | xargs -d '\n')
elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
  export $(grep -v '^#' ./docker-compose/envs/common-backend.env | xargs -0)
fi