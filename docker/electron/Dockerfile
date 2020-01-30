FROM node:10

RUN apt-get update

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
 apt-get -y install libgtkextra-dev \
 libgconf2-dev libnss3 libasound2 \
 libxtst-dev libxss1 \
 xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme curl \
 fonts-dejavu fonts-liberation hicolor-icon-theme \
 libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
 libasound2 libglib2.0 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
 libgl1-mesa-glx libgl1-mesa-dri libstdc++6 \
 gstreamer-1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav


CMD ["./node_modules/.bin/electron ./ --no-sandbox"]
