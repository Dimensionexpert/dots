 #!/bin/bash

EDITOR=code
BASE=${1:-~/.config}

if [[ "$1" == "--help" ]]; then
    echo "usage: cv [--help] [file|dir]"
    echo "  cv              → open editor"
    echo "  cv <file>       → open file"
    echo "  cv <dir>        → pick file with fzf"
    exit 0
fi

if [[ -z "$1" ]]; then
    $EDITOR
    exit 0
fi

if [[ -f "$1" ]]; then
    $EDITOR "$1"
elif [[ -d "$1" ]]; then
    TOFIND=$(find "$BASE" -type f | fzf)
    [[ -z "$TOFIND" ]] && exit 0
    $EDITOR "$TOFIND"
else
    $EDITOR "$1"
fi