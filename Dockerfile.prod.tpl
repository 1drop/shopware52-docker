#++++++++++++++++++++++++++++++++++++++
# PHP application Docker container
#++++++++++++++++++++++++++++++++++++++

FROM webdevops/php-nginx:ubuntu-16.04

ENV PROVISION_CONTEXT "production"
ENV SHOPWARE_ENV "production"
ENV WEB_DOCUMENT_ROOT "/app/"
ENV WEB_DOCUMENT_INDEX "shopware.php"
ENV CLI_SCRIPT "/app/bin/console"

# Deploy scripts/configurations
COPY etc/             /opt/docker/etc/
COPY provision/       /opt/docker/bin/

RUN mv /opt/docker/etc/php/production.ini /opt/docker/etc/php/php.ini

# Install ioncube
RUN chmod +x /opt/docker/etc/php/ioncube.sh && /opt/docker/etc/php/ioncube.sh

# Install additional packages
RUN /usr/local/bin/apt-install apt-utils mysql-client php-imagick

# Configure volume/workdir
RUN mkdir -p /app/
WORKDIR /app/
RUN git clone --depth 1 -b "v{{SHOPWARE_VERSION}}" https://github.com/shopware/shopware.git /app/ \
    && echo "{{SHOPWARE_VERSION}}" > recovery/install/data/version \
    && sed -i 's/\_\_\_VERSION\_\_\_/{{SHOPWARE_VERSION}}/g' engine/Shopware/Application.php \
    && sed -i 's/\_\_\_VERSION\_TEXT\_\_\_//g' engine/Shopware/Application.php \
    && sed -i "s/\_\_\_REVISION\_\_\_/$(git rev-parse --short HEAD)/g" engine/Shopware/Application.php
RUN composer install --no-dev --no-interaction --no-progress -a
RUN touch /app/recovery/install/data/install.lock
RUN chown -R application:application /app/
