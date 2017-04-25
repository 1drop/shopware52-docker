go-replace \
    -s "<MYSQL_ROOT_PASSWORD>" \
    -r "$MYSQL_ROOT_PASSWORD" \
    --path=/opt/docker/etc/mysql/ \
    --path-pattern='*.cnf' \
    --ignore-empty
go-replace \
    -s "<MYSQL_DATABASE>" \
    -r "$MYSQL_DATABASE" \
    --path=/opt/docker/etc/mysql/ \
    --path-pattern='*.cnf' \
    --ignore-empty

cp /opt/docker/etc/mysql/my.cnf /root/.my.cnf
chown root:root /root/.my.cnf
chmod 0644 /root/.my.cnf

cp /opt/docker/etc/mysql/my.cnf /home/.my.cnf
chown $APPLICATION_USER:$APPLICATION_USER /home/.my.cnf
chmod 0644 /home/.my.cnf
