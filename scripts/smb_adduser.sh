#!/bin/sh

set -e

USER=$1
PASS=$2

PROJEKTNAME=$USER

useradd -m -K UID_MIN=2000 -s /bin/bash $USER
LANG=C mysmbpasswd -a "$USER" "$PASS"

test -d /etc/samba/shares || mkdir -p /etc/samba/shares

## Share anlegen:

echo "[$PROJEKTNAME]
path = /home/$PROJEKTNAME
writable = yes
browseable = yes
valid users = $USER" > /etc/samba/shares/$PROJEKTNAME

## Share hinzufügen:

echo "include = /etc/samba/shares/$PROJEKTNAME" >> /etc/samba/smbshares.conf
