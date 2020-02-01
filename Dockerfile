FROM gradle:4.10.0-jdk8
USER root
ENV SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    ANDROID_HOME="/usr/local/android-sdk" \
    ANDROID_VERSION=28 \
    ANDROID_BUILD_TOOLS_VERSION=27.0.3
# Download Android SDK
RUN mkdir "$ANDROID_HOME" .android \
    && cd "$ANDROID_HOME" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && mkdir "$ANDROID_HOME/licenses" || true \
    && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "$ANDROID_HOME/licenses/android-sdk-license"
#    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
# Install Android Build Tool and Libraries
RUN $ANDROID_HOME/tools/bin/sdkmanager --update
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools"
# Install Build Essentials
RUN apt-get update && apt-get install build-essential -y && apt-get install file -y && apt-get install apt-utils -y
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install npm -y
RUN npm install -g cordova cordova-android
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

RUN npm install --save-dev electron
RUN apt-get clean
