#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source $BASE_DIR/bin/setup-utilities.sh

log "installing basic software packages"
apt-get -y update
apt-get install -y vim \
	awscli \
	curl \
	gimp \
	terminator \
	python-gpgme \
	npm \
	exfat-fuse \
	exfat-utils \
	lsb \
	samba-common-bin \
	soundconverter \
	xserver-xorg-core \
	xserver-xorg-input-libinput \
	apt-transport-https \
	ffmpeg

log "downloading third-party packages"
wget -O $HOME/Downloads/slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.2-amd64.deb
wget -O $HOME/Downloads/vagrant.deb https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb
wget -O $HOME/Downloads/steam.deb https://steamcdn-a.akamaihd.net/client/installer/steam.deb
wget -O $HOME/Downloads/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

log "planting configuration files"
place_file $BASE_DIR/config/terminator.config  $HOME/.config/terminator/config
place_file $BASE_DIR/config/.bash_aliases $HOME/.bash_aliases
place_file $BASE_DIR/config/.gitconfig $HOME/.gitconfig
place_file $BASE_DIR/config/.vimrc $HOME/.vimrc

log "installing docker"
install_docker

log "installing sublime"
install_sublime

log "installing ansible"
install_ansible

log "installing virtualbox"
install_virtualbox

log "installing vscode"
install_vscode
install_vscode_plugins

log "creating work directory"
mkdir -p $HOME/working