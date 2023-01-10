#!/bin/bash

#Inspired by https://unix.stackexchange.com/questions/313644/execute-command-or-function-when-sigint-or-sigterm-is-send-to-the-parent-script/313648
on_kill() {
    echo "Stopping vncserver"
    vncserver -kill :0
    echo "Killing child processes"
    # Override trap before killing child processes
    trap - SIGINT SIGTERM
    # Kill child processes
    kill -- -$$
}

# We want to close the vncserver when this script is terminated
trap on_kill SIGINT SIGTERM

echo "Kill the old vncserver, if it exists. Ignore error message about not being able to find the file/kill Xtightvnc"
vncserver -kill :0

vncserver :0
# We need to sleep forever because vncserver returns immediately rather than waiting for the session to terminate
sleep infinity