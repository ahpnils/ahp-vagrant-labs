#!/usr/bin/env bash

for sv_nb in 11 12 13; do
  if [ "${HOSTNAME}" != "server${sv_nb}" ]; then
    echo "10.13.37.${sv_nb} server${sv_nb}.example.com server${sv_nb}" >> /etc/hosts
  fi
done

apt-get update
apt-get -qq install -y curl wget vim git rsync

#apt-get -qq install -y apache2
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi
