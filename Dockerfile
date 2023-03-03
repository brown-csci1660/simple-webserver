FROM httpd:2.4

# Install a couple of tools for testing purposes
RUN apt-get update && \
    apt-get -y install nano screen tmux htop

# Update UID/GID for web user to use (probably) same user as at build time
RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data

# Copy in apache config
COPY apache2-config.conf /etc/apache2/sites-enabled/000-default.conf
COPY apache2-run entrypoint /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint"]

CMD [ "/usr/local/bin/apache2-run" ]