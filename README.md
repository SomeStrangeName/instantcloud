# instantcloud
Docker based Nextcloud installation in a QEMU/KVM machine using Vagrant for setup

## Motivation
This repository sets up a virtual machine with nextcloud inside. It should help to evaluate it.

## Contribute?
If you see issues, bad code :) or have some feedback, just open an issue and let me know.

## Content
You can clone this repository and start a new virtual machine with the command: vagrant up
It will use libvirt as provider and creates a new QEMU/KVM with a Debian 9 (stretch) in it.

After that a docker environment will be installed to setup a running Nextcloud instance and a database instance.
The database is not yet used!

## Prerequisites
To build the wiki you need following software packages (available in Debian 9 stretch):

| Package         | Version       |
| --------------- | ------------- |
| virt-manager    | 1.4.0         |
| libvirt0        | 3.0.0-4       |
| vagrant         | 1.9.1         |
| vagrant-libvirt | 0.0.37-1      |
| qemu-kvm        | 2.8           |

## Usage
1. `git clone https://github.com/SomeStrangeName/instantcloud.git`
2. adapt files according to your needs (for example the database password)
3. `vagrant up` (this may take some time :))
4. open url in your browser: http://192.168.33.89:8080/

You will see the initial MediaWiki setup screen.

## Used software inside the vm
Two docker images:
1. MariaDB: https://hub.docker.com/_/mariadb/
2. Nextcloud: https://hub.docker.com/_/nextcloud/
