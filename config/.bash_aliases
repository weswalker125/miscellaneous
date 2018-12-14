#!/bin/bash

alias secret_upload="aws s3 cp $HOME/Documents/sensitives.kdbx s3://wes.backup.repo/sensitives.kdbx"
alias secret_download="aws s3 cp s3://wes.backup.repo/sensitives.kdbx $HOME/Documents/sensitives.kdbx"
alias prettyjson='python -m json.tool'
set -o vi
source $HOME/miscellaneous/bin/setup-utilities.sh