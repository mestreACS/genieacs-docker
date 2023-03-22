#!/bin/sh

#TODO -> Create generate(version) function

genieAcsVersions=("1.2.4" "1.2.5" "1.2.6" "1.2.8" "1.2.9")

for version in "${genieAcsVersions[@]}"
do
  printf "Generating $version\n"
  docker build --build-arg GENIEACS_VERSION=$version . -t vagkaefer/genieacs-docker:$version 2> ./log-$version.txt

  if [ $? -ne 0 ];
  then
      printf "Error - Check logs in file log-$version.txt\n"
      exit 1
  else
    printf "\tOK - Generated\n"
  fi

done

printf "Generating Latest (V. $version)\n"

docker build --build-arg GENIEACS_VERSION=$version . -t vagkaefer/genieacs-docker 2> ./log-latest.txt

  if [ $? -ne 0 ];
  then
      printf "Error - Check logs in file log-latest.txt\n"
      exit 1
  else
    printf "\tOK - Generated\n"
  fi

# TODO IF

