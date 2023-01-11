FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
#TODO: Combine all apt commands https://runnable.com/blog/9-common-dockerfile-mistakes
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install kde-standard -y
#RUN apt-get install kde-plasma-desktop -y
RUN apt-get install tightvncserver -y
#Possibly change next line now that dbus should be working :)
RUN apt-get install dbus-x11 -y
RUN rm -rf /var/lib/apt/lists/*
# Based on https://stackoverflow.com/questions/48601146/docker-how-to-set-tightvncserver-password
RUN /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"
COPY kde_desktop_entrypoint.sh /kde_desktop_entrypoint.sh
RUN chmod +x /kde_desktop_entrypoint.sh
#This makes it so that KDE's default desktop manager doesn't run in the background :)
RUN systemctl disable sddm.service
COPY kde_desktop.service /etc/systemd/system/kde_desktop.service
RUN systemctl enable kde_desktop.service
# The following two lines don't work? I need to add to the file manually for some odd reason.
# ADD --chown=root xstartup /root/.vnc/xstartup
# RUN chmod 755 /root/.vnc/xstartup
#ENTRYPOINT ["/bin/sh"]
ENTRYPOINT ["/usr/lib/systemd/systemd", "--system"]

#TODO: make the kde_desktop show the kde desktop (see https://www.linuxquestions.org/questions/linux-networking-3/editing-the-~-vnc-xstartup-file-453603/)
#TODO: Add a volume here :)