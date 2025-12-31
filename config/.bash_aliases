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

music_dir() {
    # get first character of input
    first_char=${1:0:1}

    # determine this subdirectory this artist's name falls under
    s3_dir="s3://wes.music.repo"
    case $first_char in
        [a-cA-C0-9]*)
            s3_dir="$s3_dir/A-C"
            ;;
        [d-lD-L]*)
            s3_dir="$s3_dir/D-L"
            ;;
        [m-zM-Z]*)
            s3_dir="$s3_dir/M-Z"
            ;;
    esac

    # tack on the entire artist's name
    s3_dir="$s3_dir/${@}/"

    echo "$s3_dir"
    aws s3 ls "$s3_dir"
}

PATH="$HOME/bin:$HOME/npm/bin:$PATH"
