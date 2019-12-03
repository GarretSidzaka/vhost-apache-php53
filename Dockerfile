FROM ubuntu:16.04
MAINTAINER GarretSidzaka <GarretSidzaka@2enp.com>

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get install -y \
      apache2 \
      php5 \
      php5-cli \
      libapache2-mod-php5 \
      php5-gd \
      php5-ldap \
      php5-mysql \
      php5-pgsql && \
    mkdir /etc/apache2/ssl && \
    mkdir /etc/apache2/ssl/private && \
    chmod 755 /etc/apache2/ssl && \
    chmod 710 /etc/apache2/ssl/private

COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
EXPOSE 443
CMD ["/usr/local/bin/run"]
