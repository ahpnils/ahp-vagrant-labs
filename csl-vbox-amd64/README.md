# csl-libvirt-amd64

Cet environnement a pour but de faciliter la mise en place des machines
virtuelles du [cours serveur Linux](https://github.com/ahpnils/cours-server-linux). Il déploie 3 machines virtuelles sous Debian, ayant chacune 1 processeur virtuel et 512Mo de mémoire vive.

Cet environnement est à destination de machines physiques utilisant VirtualBox
comme système de virtualisation, pour 86_64, et utilise le provider intégré Vagrant.

Des redirections de ports sont en place :
- les port 22, 80 et 443 de server11 sont redirigés vers, respectivement les
  ports 2211, 8011 et 4311 ;
- les port 22, 80 et 443 de server12 sont redirigés vers, respectivement les
  ports 2212, 8012 et 4312 ;
- les port 22, 80 et 443 de server13 sont redirigés vers, respectivement les
  ports 2213, 8013 et 4313.

