printenv | sed 's/^\(.*\)$/export \1/g' > /opt/project_env.sh
chmod 0755 /opt/project_env.sh
cp /opt/docker/etc/cron/crontab /etc/cron.d/docker-boilerplate
chown root:root /etc/cron.d/docker-boilerplate
chmod 0644 /etc/cron.d/docker-boilerplate
