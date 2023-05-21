# Genieacs-docker

# Information

A docker image and compose to run GenieACS 

This project is not an official repository from GenieACS developers, but we use the official source code of the GenieACS.

## About the image

The images are available in [Docker Hub](https://hub.docker.com/r/vagkaefer/genieacs-docker).

The script used to generate the image are available here in the project (generate-images.sh) and the Dockerfile uses the oficial package of [GenieAcs](https://www.npmjs.com/package/genieacs)
## How to run

1) Install Docker and Docker Compose on your Linux
2) Rename the .env.example to .env and change the values
3) Run "docker-compose up -d"

The webserver will be available in the default genieacs port (3000)

If running localhost, access http://localhost:3000 on your device

## More info

This script will start all default services of GenieAcs (UI, NBI, FS and CWMP), please read the [docs of the project](http://docs.genieacs.com/) and configure a firewall to avoid unwanted access.

# Contribution

Feel free to help with this project. 