#!/usr/bin/env bash

set -e
file=$(realpath "$HOME/.local/bin/AC_Power_Sleep_Inhibitor.sh")
uninstallfile=$(realpath "$HOME/.local/bin/uninstall_AC_Power_Sleep_Inhibitor.sh")
local=$(realpath "./AC_Power_Sleep_Inhibitor.sh")
uninstalllocal=$(realpath "./uninstall.sh")
cp -v $local $file
cp -v $uninstalllocal $uninstallfile
chmod -v 744 $file
chmod -v 744 $uninstallfile
