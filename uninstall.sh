#!/usr/bin/env bash

set -e
file=$(realpath "$HOME/.local/bin/AC_Power_Sleep_Inhibitor.sh")
uninstallfile=$(realpath "$HOME/.local/bin/uninstall_AC_Power_Sleep_Inhibitor.sh")

$file stop

rm -v $file $uninstallfile
