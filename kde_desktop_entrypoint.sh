#!/bin/bash

USER=root
HOME=/root
export USER HOME

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

echo "Killing the old vncserver, if it exists. Ignore error message about not being able to find the file/kill Xtightvnc"
vncserver -kill :0

# I WOULD just copy this in the docker, but it was hitting some odd error about the vncserver not finding it :/
# This is the script that vncserver runs to start everything
# cat <<EOF > /root/.vnc/xstartup
# #!/bin/sh
# [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
# unset SESSION_MANAGER
# unset DBUS_SESSION_BUS_ADDRESS
# xsetroot -solid grey
# export DESKTOP_SESSION=plasma
# kdeinit5 #Maybe? TODO: Try using startx / xinit
# # dbus-run-session startplasma-x11
# dbus-launch --exit-with-session startplasma-x11 &
# systemsettings &
# # x-window-manager &
# # startplasma-x11
# # kdeinit5
# EOF

# chmod +x /root/.vnc/xstartup

vncserver :0
# We need to sleep forever because vncserver returns immediately rather than waiting for the session to terminate
tail -f /root/.vnc/*.log
# alternatively sleep infinity