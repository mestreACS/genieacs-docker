#!/bin/bash

# Carregar variáveis do arquivo .env
if [ -f .env ]; then
    export $(cat .env | sed 's/#.*//g' | xargs)
fi

if test -z "$TOKEN"; then
    echo "Erro: Token não informado..."
    exit 1
fi

DOCKER_USER=vagkaefer

echo "$TOKEN" | docker --config ./.docker-config login --username $DOCKER_USER --password-stdin

docker pull alpine:3

export DOCKER_CONFIG=./.docker-config

# Criar e usar o builder com suporte multiplataforma
docker buildx create --name $DOCKER_USER --use
docker buildx inspect --bootstrap

if [ -z "$1" ]
then
  printf "Versão não informada, gerando toda base\n"
  genieAcsVersions=("1.2.2" "1.2.3" "1.2.4" "1.2.5" "1.2.6" "1.2.8" "1.2.9" "1.2.10" "1.2.11" "1.2.12" "1.2.13")
else
  printf "Gerando imagem da versão v$1\n"
  genieAcsVersions=($1)
fi

for version in "${genieAcsVersions[@]}"
do
  printf "Generating $version\n"
  docker buildx build --push --platform linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/386 --build-arg GENIEACS_VERSION=$version . -t vagkaefer/genieacs-docker:$version 2> ./log-$version.txt

  if [ $? -ne 0 ];
  then
      printf "Error - Check logs in file log-$version.txt\n"
      exit 1
  else
    printf "\tOK - Generated\n"
  fi

done

printf "Generating Latest (V. $version)\n"

docker buildx build --push --platform linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/386 --build-arg GENIEACS_VERSION=$version . -t vagkaefer/genieacs-docker 2> ./log-latest.txt

  if [ $? -ne 0 ];
  then
      printf "Error - Check logs in file log-latest.txt\n"
      exit 1
  else
    printf "\tOK - Generated\n"
  fi

printf "Generating Dev\n"

docker buildx build --push --platform linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/386 . -t vagkaefer/genieacs-docker:dev 2> ./log-dev.txt

  if [ $? -ne 0 ];
  then
      printf "Error - Check logs in file log-dev.txt\n"
      exit 1
  else
    printf "\tOK - Generated\n"
  fi

# Remover o builder após o build
docker buildx rm $DOCKER_USER