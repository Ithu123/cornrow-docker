#!/bin/bash -ex

# edit config
sed -ri "s/^#?\s*Name\s*=.*/Name=$CORNROW_NAME/" /etc/bluetooth/main.conf

# run dbus-daemon
if [ -f "/run/dbus/pid" ]; then
  rm /run/dbus/pid
fi
dbus-daemon --system --fork

# start bluetooth service
service bluetooth start
while ! service bluetooth status | grep 'bluetooth is running.'; do
    sleep 1
done

# start cornrowd
/usr/bin/cornrowd
