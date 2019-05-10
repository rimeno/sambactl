#!/bin/sh

set -e

USER=$1
PASS=$2

PROJEKTNAME=$USER

useradd -m -K UID_MIN=2000 -s /bin/bash $USER
LANG=C mysmbpasswd -a "$USER" "$PASS"

test -d /etc/samba/shares || mkdir -p /etc/samba/shares
test -d /etc/samba/users || mkdir -p /etc/samba/users

## Share anlegen:

echo "[$PROJEKTNAME]
path = /home/$PROJEKTNAME
writable = yes
browseable = no
create mask = 0600
directory mask = 0700
spotlight = yes
vfs objects = catia fruit streams_xattr
fruit:aapl = yes
fruit:time machine = yes
valid users = $USER
include /etc/samba/users/%U.conf" > /etc/samba/shares/$PROJEKTNAME

## Share hinzufügen:

echo "include = /etc/samba/shares/$PROJEKTNAME" >> /etc/samba/smbshares.conf
echo "browseable = yes" > /etc/samba/users/${USER}.conf
