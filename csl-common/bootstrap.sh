#!/usr/bin/env bash

for sv_nb in 11 12 13; do
  if [ "${HOSTNAME}" != "server${sv_nb}" ]; then
    echo "10.13.37.${sv_nb} server${sv_nb}.example.com server${sv_nb}" >> /etc/hosts
  fi
done

echo -n "Installing some more packages..."
DEBIAN_FRONTED=noninteractive apt-get update > /dev/null 2>&1
DEBIAN_FRONTED=noninteractive apt-get -qq install -y curl wget vim > /dev/null 2>&1
echo " done."

if ! [ -L /var/www/html ]; then
	mkdir -p /var/www
  rm -rf /var/www/html
  ln -fs /vagrant/csl-common/${HOSTNAME} /var/www/html
fi
