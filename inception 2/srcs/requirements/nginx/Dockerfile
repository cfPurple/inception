FROM debian:buster

# Mise à jour et installation des paquets nécessaires
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y openssl nginx vim curl

# Génération des certificats SSL
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/cfelix.42.fr.crt -keyout /etc/nginx/ssl/cfelix.42.fr.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cfelix.42.fr/UID=cfelix"

# Copier le fichier de configuration Nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Créer le répertoire pour Nginx et définir les permissions
RUN mkdir -p /var/run/nginx
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Exposer les ports 80 pour HTTP et 443 pour HTTPS
EXPOSE 443

#copy entrypoint
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]