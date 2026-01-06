#!/usr/bin/env bash

for sv_nb in 11 12 13; do
  if [ "${HOSTNAME}" != "server${sv_nb}" ]; then
    echo "10.13.37.${sv_nb} server${sv_nb}.example.com server${sv_nb}" >> /etc/hosts
  fi
done

echo -n "Configuring shell for vagrant user..."
chsh -s /bin/bash vagrant
echo " done."

echo -n "Installing some more packages..."
DEBIAN_FRONTED=noninteractive apt-get update > /dev/null 2>&1
DEBIAN_FRONTED=noninteractive apt-get -qq install -y curl wget vim > /dev/null 2>&1
echo " done."

echo -n "Shutting down and disabling unwanted services..."
systemctl disable --now unattended-upgrades.service > /dev/null 2>&1
echo "done."

echo -n "Reactivating SSH password authentication..."
echo "PasswordAuthentication yes" > /etc/ssh/sshd_config.d/zzz_csl_tweaks.conf
echo "MaxAuthTries 20" >> /etc/ssh/sshd_config.d/zzz_csl_tweaks.conf
systemctl restart ssh.service > /dev/null 2>&1
echo "done."
