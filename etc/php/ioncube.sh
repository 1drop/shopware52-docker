#!/bin/bash

echo "Installing ionCube loader"

DOWNLOAD_URL="http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz"
PHP_VERSION=`php -v | head -1 | grep -o 'PHP [0-9].[0-9]' | sed -r 's/PHP //g'`
PHP_EXTENSION_DIR=`php -i | grep -o -m 1 'extension_dir .* =' | sed -r 's/extension_dir => //g' | sed -r 's/ =//g'`
TMP_FILE="/tmp/ioncube_loaders.tar.gz"
MOD_INI="/etc/php/$PHP_VERSION/mods-available/ioncube.ini"
SO_FILE="$PHP_EXTENSION_DIR/ioncube_loader_lin_$PHP_VERSION.so"

echo "PHP-VERSION: $PHP_VERSION"
echo "PHP-EXTENSION-DIR: $PHP_EXTENSION_DIR"
echo "$SO_FILE"

echo "Downloading ..."
curl -sS $DOWNLOAD_URL -o $TMP_FILE

echo "Unpacking ..."
tar -xzf $TMP_FILE -C /tmp

echo "Installing ..."
cp "/tmp/ioncube/ioncube_loader_lin_$PHP_VERSION.so" $SO_FILE
echo "[ioncube]" > $MOD_INI
echo "zend_extension = $SO_FILE" >> $MOD_INI
echo "; priority=01" >> $MOD_INI
rm -rf $TMP_FILE
rm -rf /tmp/ioncube

echo "Enable PHP module"
phpenmod ioncube
