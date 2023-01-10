FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install kde-plasma-desktop -y
RUN apt-get install tightvncserver -y
RUN rm -rf /var/lib/apt/lists/*
# Kudos to https://www.linuxquestions.org/questions/linux-newbie-8/cannot-start-vnc-server-because-the-user-environment-variable-is-not-set-79621/ for setting these variables
ENV USER=root
ENV HOME=/root
RUN mkdir /root/.vnc
# Kudos to https://stackoverflow.com/questions/48601146/docker-how-to-set-tightvncserver-password
RUN /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"
ADD kde_desktop_entrypoint.sh kde_desktop_entrypoint.sh
RUN chmod +x kde_desktop_entrypoint.sh
#RUN vncserver :0
#CMD sleep infinity
CMD ./kde_desktop_entrypoint.sh

#TODO: Consider x11vnc (https://linuxconfig.org/how-to-share-your-desktop-in-linux-using-x11vnc). It seems to be able to do `-forever`
#TODO: Debug a little with tightvncviewer and checking ports :(
#TODO: Make sure vncserver runs. Look into https://unix.stackexchange.com/questions/313644/execute-command-or-function-when-sigint-or-sigterm-is-send-to-the-parent-script/313648
#       and maybe ENTRYPOINT vs CMD. Run a script that starts vncserver and closes it when SIGTERM is received.
#TODO: Make sure guacamole can connect to the kde_desktop at all (WIP)
#TODO: make the kde_desktop show the kde desktop (see https://www.linuxquestions.org/questions/linux-networking-3/editing-the-~-vnc-xstartup-file-453603/)
#TODO: Add a volume here :)