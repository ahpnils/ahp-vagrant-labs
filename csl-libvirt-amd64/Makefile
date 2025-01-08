clean:
	rm -f *~ .*~

check:
	vagrant validate

fedora-deps:
	sudo dnf --refresh -y install qemu-kvm libvirt-daemon-kvm vagrant vagrant-libvirt virtiofsd
	sudo systemctl is-active libvirtd || sudo systemctl enable --now libvirtd
	mkdir -p ${HOME}/libvirt/vagrant_images
	chown -R qemu:qemu ${HOME}/libvirt/vagrant_images
	sudo virsh pool-define-as vagrant_images --type dir --target ${HOME}/libvirt/vagrant_images
	sudo virsh pool-start vagrant_images

ubuntu-deps:
	sudo sed -i -e "s/deb$$/deb deb-src/g" /etc/apt/sources.list.d/ubuntu.sources
	sudo apt -y update
	sudo apt -y install wget
	wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [arch=$$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	sudo apt -y update 
	sudo apt-get -y build-dep ruby-libvirt
	sudo apt -y install vagrant qemu-kvm libvirt-daemon-system libvirt-daemon libosinfo-bin qemu-system virtiofsd libguestfs-tools libxslt-dev libxml2-dev zlib1g-dev ruby-dev
	vagrant plugin install vagrant-libvirt
	sudo systemctl is-active libvirtd || sudo systemctl enable --now libvirtd
	mkdir -p ${HOME}/libvirt/vagrant_images
	sudo chown -R libvirt-qemu:kvm ${HOME}/libvirt/vagrant_images
	# allow Qemu process to enter the home and storage pool directories
	chmod 0755 ${HOME}
	sudo chmod 0775 ${HOME}/libvirt/vagrant_images
	sudo virsh pool-define-as vagrant_images --type dir --target ${HOME}/libvirt/vagrant_images
	sudo virsh pool-start vagrant_images

up:
	vagrant up --parallel

destroy:
	vagrant destroy -f --parallel

status:
	vagrant status
