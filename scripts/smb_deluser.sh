#!/bin/sh

BACKUP=/home/archive
USER=$1
PROJEKTNAME=$USER


## SMB Sessions schließen (optional?)

#?? (sonst kommt beim löschen mit deluser: userdel: user testuser2 is currently used by process 4347)

## User löschen:

smbpasswd -x $USER
deluser $USER

## Share Ordner löschen:

test -d $BACKUP || mkdir -p $BACKUP

ts=$(date "+%Y%m%d%H%M%S")
targetdir=${BACKUP}/${PROJEKTNAME}.${ts}
sharedir=/home/$PROJEKTNAME
i=0
while [ $i -lt 100 ]; do
	if [ ! -d ${targetdir}.$i ]; then
		mv $sharedir ${targetdir}.$i
		break
	fi
	i=$(($i + 1))
done
if [ -d $sharedir ]; then
	rm -r $sharedir
fi

## Share löschen:

rm /etc/samba/shares/$PROJEKTNAME

## Share austragen:

sed -i "/include = \/etc\/samba\/shares\/$PROJEKTNAME/d" /etc/samba/smbshares.conf
rm /etc/samba/users/${USER}.conf
