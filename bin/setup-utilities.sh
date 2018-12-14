#!/bin/bash

function install_docker {
    apt-get remove docker docker-engine docker.io
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor > docker.gpg
    mv docker.gpg /etc/apt/trusted.gpg.d/docker.gpg
    sh -c 'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/vscode.list'
    apt-get update
    apt-get install -y docker-ce
}
export -f install_docker

function install_ansible {
    apt-get install -y software-properties-common
    apt-get update
    apt-add-repository ppa:ansible/ansible
    apt-get update
    apt-get install ansible
}
export -f install_ansible

function install_sublime {
    curl https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor > sublimetext.gpg
    mv sublimetext.gpg /etc/apt/trusted.gpg.d/sublimetext.gpg
    sh -c 'echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list'
    apt-get update
    apt-get install -y sublime-text
}
export -f install_sublime

function install_virtualbox {
    curl https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor > virtualbox.gpg
    mv virtualbox.gpg /etc/apt/trusted.gpg.d/virtualbox.gpg
    sh -c 'echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bionic contrib" > /etc/apt/sources.list.d/vscode.list'
    apt-get update
    apt-get install -y virtualbox-5.2
}
export -f install_virtualbox

function install_vscode {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    apt-get update
    apt-get install -y code
}
export -f install_vscode

function install_vscode_plugins {
    EXTENSIONS=(
        ms-vscode.cpptools
        ms-vscode.csharp
        ms-python.python
        redhat.java
        ms-vscode.go
        peterjausovec.vscode-docker
        vscjava.vscode-java-debug
        vscjava.vscode-java-pack
        vscoss.vscode-ansible
        shakram02.bash-beautify
    )

    if type code 2>/dev/null; then
        echo "Installing plugins..."
        for ext in "${EXTENSIONS[@]}"; do
            sh -c "code --install-extension $ext"
        done
    else
        echo "Failed to fully install VS Code."
    fi
}
export -f install_vscode_plugins

function place_file {
	NEW_FILE="$1"
	ORIGINAL_FILE="$2"
	# backup original file
	if [ -e $ORIGINAL_FILE ]; then
		mv $ORIGINAL_FILE "${ORIGINAL_FILE}.$(date +%Y%m%d-%H%M%S).bak"
	fi
	
	# check that path structure exists
	if [ ! -d $(dirname $ORIGINAL_FILE) ]; then
		mkdir -p $(dirname $ORIGINAL_FILE)
	fi
	cp $NEW_FILE $ORIGINAL_FILE
}
export -f place_file

function log {
    echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $@"
}
export -f log