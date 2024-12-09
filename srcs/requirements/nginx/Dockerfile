FROM debian:bullseye

# install NGINX + dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx vim curl openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/cfelix.42.fr.crt -keyout /etc/nginx/ssl/cfelix.42.fr.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cfelix.42.fr/UID=cfelix"

# set working directory
WORKDIR /etc/nginx

# copy the provided config file to the container
COPY ./conf/nginx.conf /etc/nginx
RUN chown -R www-data:www-data /var/www/html

# expose port 443 for HTTPS traffic
EXPOSE 443

# copy entrypoint script
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
