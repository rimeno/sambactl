sambactl
========

A simple web interface for managing users and samba shares. Samba authentication
uses unix users, therefor this tool creates a unix user, adds it to smbpasswd
and creates a share directory.

Each user has a single share, groups are not supported yet. At the time of
writing no additional features are planned.

Dependencies
------------

* Samba (> 4.8 for timemachine compatibility)
* Apache (you may need to change stuff for other httpds)
* mod\_fastcgi
* Sudo (So sambactl-worker has the rights to manage samba)
* expect
* [Go](http://golang.org/)

Installation
------------

	make
	make install

Binaries and scripts are installed in `/usr/local/bin/`. Web files are installed in `/usr/local/sambactl/`.

Configuration
-------------

Create *htpasswd* file :

	htpasswd -c /usr/local/sambactl/htpasswd admin

Set your language for the web interface :

	cd /usr/local/sambactl/htdocs
	ln -s index.en.html index.html

Configure Apache :

	cp configs/apache.conf /etc/apache2/sites-available/sambactl.conf
	a2ensite sambactl.conf
	systemctl reload apache2.service

Configure *sudo* :

	cp configs/sudoers /etc/sudoers.d/sambactl

Configure Samba :

Set **security** to **user** and add `include = /etc/samba/smbshares.conf`.
