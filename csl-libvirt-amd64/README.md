# csl-libvirt-amd64

Cet environnement a pour but de faciliter la mise en place des machines
virtuelles du [cours serveur Linux](https://github.com/ahpnils/cours-server-linux). Il déploie 3 machines virtuelles sous Debian, ayant chacune 1 processeur virtuel et 512Mo de mémoire vive.

Cet environnement est à destination de machines physiques x86_64 utilisant libvirt
comme système de virtualisation, et utilise le provider libvirt pour Vagrant.

Des redirections de ports sont en place :
- les port 22, 80 et 443 de server11 sont redirigés vers, respectivement les
  ports 2211, 8011 et 4311 ;
- les port 22, 80 et 443 de server12 sont redirigés vers, respectivement les
  ports 2212, 8012 et 4312 ;
- les port 22, 80 et 443 de server13 sont redirigés vers, respectivement les
  ports 2213, 8013 et 4313.

## Installation

Attention : Hashicorp, l'éditeur de Vagrant, propose [ses propres
dépôts](https://www.hashicorp.com/blog/announcing-the-hashicorp-linux-repository).
Pour l'utilisation de Vagrant dans ce cas de figure, il est recommandé
d'utiliser les paquets fournis par la distribution et non ceux de Hashicorp. Si
le dépôt Hashicorp est installé pour d'autres logiciels, consulter la
documentation de la distribution utiliséee pour exclure le vagrant upstream ou
donner la priorité au vagrant de la distribution.

### Fedora

En tant que root ou via sudo :
1. `dnf -y install qemu-kvm libvirt virt-install virt-manager` ;
2. `dnf -y install vagrant vagrant-libvirt`.

### Ubuntu / Debian

1. `sudo apt -y install qemu-kvm libvirt-daemon-system libvirt-daemon virtinst
   bridge-utils libosinfo-bin virt-manager qemu-system` ;
2. `sudo apt -y install vagrant-libvirt`.

## Utilisation

1. `git clone https://github.com/ahpnils/ahp-vagrant-labs.git` ;
2. `cd ahp-vagrant-labs/csl-libvirt-amd64/` ;
3. `vagrant up`.

Le premier lancement de `vagrant up` est plus long, cela est causé par le
téléchargement de l'image de machine virtuelle. Une fois la commande terminée,
les 3 machines virtuelles sont démarrées. Pour se connecter à chacune
d'entre elles, utiliser `vagrant ssh nomdelamachine`. Il est possible
d'utiliser `vagrant halt` pour les arrêter et `vagrant destroy` pour supprimer
l'environnement : attention, les machines virtuelles sont alors supprimées !
