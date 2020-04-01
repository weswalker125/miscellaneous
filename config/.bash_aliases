#!/bin/bash

set -o vi
alias prettyjson='python -m json.tool'
alias myip='ifconfig | grep inet'
alias restart='service restart'
alias hl='highlight -O ansi'

open () {
    xdg-open "$@" &>/dev/null
}

export S3_BACKUP=s3://wes.backup.repo
export S3_MUSIC=s3://wes.music.repo
export NODE_PATH="$NODE_PATH:$HOME/npm/lib/node_modules"

alias secret_upload="aws s3 cp $HOME/sensitives.kdbx $S3_BACKUP/sensitives.kdbx"
alias secret_download="aws s3 cp $S3_BACKUP/sensitives.kdbx $HOME/sensitives.kdbx"

if [ -e $HOME/miscellaneous/bin/setup-utilities.sh ]; then
    source $HOME/miscellaneous/bin/setup-utilities.sh
    echo "setup-utilities loaded."
fi

PATH="$HOME/bin:$HOME/npm/bin:$PATH"