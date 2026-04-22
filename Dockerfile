FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libxml2-dev libzip-dev libbz2-dev libicu-dev \
    libldap2-dev unzip curl netcat-openbsd \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli pdo pdo_mysql gd exif zip bz2 xml intl opcache ldap \
    && rm -rf /var/lib/apt/lists/*

RUN echo "session.cookie_httponly = on" >> /usr/local/etc/php/conf.d/security.ini

ADD https://github.com/glpi-project/glpi/releases/download/10.0.16/glpi-10.0.16.tgz /tmp/glpi.tgz

RUN tar -xzf /tmp/glpi.tgz -C /var/www/html --strip-components=1 \
    && rm /tmp/glpi.tgz

RUN chown -R www-data:www-data /var/www/html \
    && mkdir -p /var/www/html/files /var/www/html/config

RUN printf '%s\n' \
'<IfModule mod_rewrite.c>' \
'    RewriteEngine On' \
'    RewriteCond %{REQUEST_FILENAME} !-f' \
'    RewriteRule ^ index.php [QSA,L]' \
'</IfModule>' \
> /var/www/html/public/.htaccess

RUN a2enmod rewrite

COPY glpi-apache.conf /etc/apache2/sites-available/000-default.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]