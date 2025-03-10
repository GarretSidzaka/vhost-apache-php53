vhost-apache-php
===================================

A Docker image based on Ubuntu 16.04, serving the old PHP 5.3 running as Apache Module. Useful for Web developers in need for an old PHP version. In addition, the `error_reporting` setting in php.ini is configurable per container via environment variable.

Tags
-----

* latest: Ubuntu 16.04 (LTS), Apache 2, PHP 5.3 with support for setting `error_reporting`

Usage
------

Clone the http_config and/or https_config apache configs to create your virtual host settings as per standard conventions.

Make sure that you put all of your virtual hosts in separate webfolders in the `/home/user/vhosts` folder and point to them in the apache configs.


```bash
$ docker run -d -p 8080:80 \
    -v /home/user/http_config:/etc/apache2/sites-available/000-default.conf \
    -v /home/user/https_config:/etc/apache2/sites-available/default-ssl.conf \
    -v /home/user/crypto:/etc/apache2/ssl \
    -v /home/user/crypto/private:/etc/apache2/ssl/private \
    -v /home/user/vhosts:/var/www \
    -e PHP_ERROR_REPORTING='E_ALL & ~E_STRICT' \
    GarretSidzaka/vhost-apache-php53
```
* `-v [local path]:/etc/apache2/sites-available/000-default` maps the custom apache config to container's apache directory
* `-v [local path]://etc/apache2/sites-available/default-ssl` maps the custom SSL apache config to container's apache directory
* `-v [local path]:/etc/apache2/ssl` maps the containers ssl keys to your keystore, be sure to make sub folder for private
* `-v [local path]:/var/www` maps the container's webroot to a folder where you keep your webfiles
* `-p [local port]:80` maps a local port to the container's HTTP port 80, alternatively you may map 443 if using TLS
* `-e PHP_ERROR_REPORTING=[php error_reporting settings]` sets the value of `error_reporting` in the php.ini files.

### Access apache logs

Apache is configured to log both access and error log to STDOUT. So you can simply use `docker logs` to get the log output:

`docker logs -f container-id`


Installed packages
-------------------
* Ubuntu Server 16.04, based on ubuntu docker image
* apache2
* php5
* php5-cli
* libapache2-mod-php5
* php5-gd
* php5-ldap
* php5-mysql
* php5-pgsql

Configurations
----------------

* Apache: .htaccess-Enabled in webroot (mod_rewrite with AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL & ~E_DEPRECATED & ~E_NOTICE (default, overridable per env variable)
