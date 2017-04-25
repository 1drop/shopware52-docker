#++++++++++++++++++++++++++++++++++++++
# PHP application Docker container
#++++++++++++++++++++++++++++++++++++++

FROM webdevops/php-nginx-dev:ubuntu-16.04

ENV PROVISION_CONTEXT "development"
ENV SHOPWARE_ENV "development"
ENV WEB_DOCUMENT_ROOT "/app/"
ENV WEB_DOCUMENT_INDEX "shopware.php"
ENV CLI_SCRIPT "/app/bin/console"
ENV WEB_NO_CACHE_PATTERN "\.(css|js|gif|png|jpg|svg)$"

# Deploy scripts/configurations
COPY etc/             /opt/docker/etc/
COPY provision/       /opt/docker/provision/

RUN mv /opt/docker/etc/php/development.ini /opt/docker/etc/php/php.ini

# Install ioncube
RUN chmod +x /opt/docker/etc/php/ioncube.sh; sync; /opt/docker/etc/php/ioncube.sh

# Install additional packages
RUN /usr/local/bin/apt-install apt-utils mysql-client php-imagick

# BEGIN - DEV ONLY
RUN /usr/local/bin/apt-install ant

# Must explicitly turned on in dev env (default off)
RUN docker-service-enable cron

# Install PHP-CodeSniffer
RUN curl -o /usr/local/bin/phpcs -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x /usr/local/bin/phpcs

# Install PHPUnit
RUN curl -o /usr/local/bin/phpunit -L https://phar.phpunit.de/phpunit.phar \
    && chmod +x /usr/local/bin/phpunit

# END - DEV ONLY

# Configure volume/workdir
RUN mkdir -p /app/
WORKDIR /app/
RUN git clone --depth 1 -b "v{{SHOPWARE_VERSION}}" https://github.com/shopware/shopware.git /app/ \
    && echo "{{SHOPWARE_VERSION}}" > recovery/install/data/version \
    && sed -i 's/\_\_\_VERSION\_\_\_/{{SHOPWARE_VERSION}}/g' engine/Shopware/Application.php \
    && sed -i 's/\_\_\_VERSION\_TEXT\_\_\_//g' engine/Shopware/Application.php \
    && sed -i "s/\_\_\_REVISION\_\_\_/$(git rev-parse --short HEAD)/g" engine/Shopware/Application.php
RUN composer install --no-interaction --no-progress -a
RUN chown -R application:application /app/
