# Default target
.DEFAULT_GOAL := help
VM_NAME =
NAME = checkpoint

fedora-deps: ## install dependencies for usage with a recent Fedora system
	sudo dnf --refresh -y install qemu-kvm libvirt-daemon-kvm vagrant vagrant-libvirt virtiofsd
	sudo systemctl is-active libvirtd || sudo systemctl enable --now libvirtd
	mkdir -p ${HOME}/libvirt/vagrant_images
	chown -R qemu:qemu ${HOME}/libvirt/vagrant_images
	sudo virsh pool-info vagrant_images || sudo virsh pool-define-as vagrant_images --type dir --target ${HOME}/libvirt/vagrant_images
	sudo virsh pool-start vagrant_images

ubuntu2204-deps: ## install dependencies for usage with an Ubuntu 22.04 system
	sudo sed -i -e "s/\# deb-src/deb-src/g" /etc/apt/sources.list
	sudo apt -y update
	sudo apt -y install wget
	wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [arch=$$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	sudo apt -y update 
	sudo apt-get -y build-dep ruby-libvirt
	sudo apt -y install vagrant qemu-kvm libvirt-daemon-system libvirt-daemon libosinfo-bin qemu-system qemu-system-common libguestfs-tools libxslt-dev libxml2-dev zlib1g-dev ruby-dev
	vagrant plugin install vagrant-libvirt
	sudo systemctl is-active libvirtd || sudo systemctl enable --now libvirtd
	mkdir -p ${HOME}/libvirt/vagrant_images
	sudo chown -R libvirt-qemu:kvm ${HOME}/libvirt/vagrant_images
	# allow Qemu process to enter the home and storage pool directories
	chmod 0755 ${HOME}
	sudo chmod 0775 ${HOME}/libvirt/vagrant_images
	sudo virsh pool-info vagrant_images || sudo virsh pool-define-as vagrant_images --type dir --target ${HOME}/libvirt/vagrant_images
	sudo virsh pool-start vagrant_images

ubuntu-deps: ## install dependencies for usage with an Ubuntu system, starting 24.04
	sudo sed -i -e "s/deb$$/deb deb-src/g" /etc/apt/sources.list.d/ubuntu.sources
	sudo apt -y update
	sudo apt -y install wget
	wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
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
	sudo virsh pool-info vagrant_images || sudo virsh pool-define-as vagrant_images --type dir --target ${HOME}/libvirt/vagrant_images
	sudo virsh pool-start vagrant_images

up: ## Bring up the environment (parallel)
	vagrant up $(VM_NAME) --parallel

up-seq: ## Bring up the environment (sequential)
	vagrant up $(VM_NAME) --no-parallel

ssh: ## Connect to the machine via SSH
	vagrant ssh $(VM_NAME)

validate: ## Lint the Vagrantfile syntax
	vagrant validate

status: ## Check the status of the machines
	vagrant status $(VM_NAME)

reload: ## Restart and apply Vagrantfile changes
	vagrant reload $(VM_NAME)

provision: ## Run provisioners on a running VM
	vagrant provision $(VM_NAME)

logs: ## Stream system logs from the VM (Journald)
	vagrant ssh $(VM_NAME) -c "sudo journalctl -f"

snapshot-save: ## Save named snapshot (libvirt compatible)
	vagrant snapshot save $(VM_NAME) $(NAME)

snapshot-restore: ## Restore named snapshot (libvirt compatible)
	vagrant snapshot restore $(VM_NAME) $(NAME)

push: ## Push current state onto the snapshot stack
	vagrant snapshot push $(VM_NAME)

pop: ## Rollback to the last pushed state on the stack
	vagrant snapshot pop $(VM_NAME)

suspend: ## Pause the VM (saves state to disk)
	vagrant suspend $(VM_NAME)

resume: ## Resume a suspended VM
	vagrant resume $(VM_NAME)

halt: ## Gracefully shut down the machines
	vagrant halt $(VM_NAME)

clean: ## Stop and delete the machines (forced)
	vagrant destroy -f $(VM_NAME)

rebuild: clean up ## Fresh start: Destroy and rebuild

prune: ## Remove stale VM entries from global index
	vagrant global-status --prune

help: ## Display this help message
	@echo "Usage: make [target] [VM_NAME=<name>]"
	@echo ""
	@echo "Targets:"
	@awk '/^[a-zA-Z_-]+:.*?##/ { \
		helpMessage = match($$0, /## (.*)/); \
		if (helpMessage) { \
			target = $$1; \
			sub(/:/, "", target); \
			printf "  \033[36m%-12s\033[0m %s\n", target, substr($$0, RSTART + 3); \
		} \
	}' $(MAKEFILE_LIST)

.PHONY: fedora-deps ubuntu2204-deps ubuntu-deps up up-seq ssh validate status reload provision logs snapshot-save snapshot-restore push pop suspend resume halt clean rebuild prune help
