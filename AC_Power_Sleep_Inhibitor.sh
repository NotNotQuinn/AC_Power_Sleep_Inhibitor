#!/usr/bin/env bash

set -e
name=AC_Power_Sleep_Inhibitor
pidfile="$(realpath $0).pid"

help() {
	cat << EOF
$name [command]

Commands:
	start - start inhibiting the screen; echos the PID
	stop - stop inhibiting the screen
	status - show status
	help - show this help

'start' and 'stop' are idempotent;
calling them multiple times achieves the same thing.
ex:
	$ # $name is not running
	$ $name start # starts
	12840
	$ $name start # no-op
	12840
	$ $name stop # stops
	$ $name stop # no-op

Files this touches:
	PID File: $pidfile

Note:
	I use:

	Operating System: Manjaro Linux
	KDE Plasma Version: 6.1.5
	KDE Frameworks Version: 6.6.0
	Qt Version: 6.7.2
	Kernel Version: 6.10.13-3-MANJARO (64-bit)
	Graphics Platform: Wayland

	This may not work for anything else.
EOF
};

status() {
	cat << EOF
PIDFILE: $pidfile
# If non-empty, assumed to be running.
PID: $(cat $pidfile 2>/dev/null)
EOF
}

start() {
	if [[ -z $(cat $pidfile 2>/dev/null) ]]; then
		systemd-inhibit --what=sleep --who="AC Power Sleep Inhibitor" --why="AC Power" sleep 365d &
		PID=$!
		echo $PID >> $pidfile
	else
		PID=$(cat $pidfile 2>/dev/null)
	fi
	echo $PID
}

stop() {
	if [[ -n $(cat $pidfile 2>/dev/null) ]]; then
		kill $(cat $pidfile 2>/dev/null)
		rm $pidfile
	fi
}

if [[ $# > 1 ]]; then
	echo >&2 "Too many arguments";
	exit 1;
fi

case "$1" in
	"status") status;;
	"start") start;;
	"stop") stop;;
	*) help;;
esac
