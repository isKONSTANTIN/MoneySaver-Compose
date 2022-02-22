#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if test -f "database_password"; then
  POSTGRES_PASSWORD=$(cat ./database_password)
else
  POSTGRES_PASSWORD=$(cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-30} | head -n 1)
  echo -e "Init default passworld for database:${YELLOW} $POSTGRES_PASSWORD ${NC}\n"
  echo $POSTGRES_PASSWORD > database_password
fi

cat ./password | docker login https://dockreg.knst.su/ --username $(cat ./login) --password-stdin

POSTGRES_PASSWORD=$POSTGRES_PASSWORD docker-compose up -d

if [[ $? -eq 0 ]]; then
  echo -e "\nMoneySaver start complited.\ndocker-compose should automatically start containers after system reboot.\nFor stop use 'docker-compose stop'"
else
  echo -e "\n${RED}Hmm... Something went wrong...${NC}\nIf you have any questions please contact the maintainer"
fi