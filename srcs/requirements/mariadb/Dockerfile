FROM debian:bullseye

# Installer le serveur et le client MariaDB
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client procps && \
    rm -rf /var/lib/apt/lists/*

# Donner des permissions sur des dossiers spécifiques
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

# Définir le répertoire de travail à l'intérieur du conteneur
WORKDIR /etc/mysql/

# Copier la configuration de MariaDB
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Copier le script d'initialisation de la base de données
COPY /tools/create_db.sh /etc/mysql/

# Accorder les permissions d'exécution au script d'initialisation de la base de données
RUN chmod +x /etc/mysql/create_db.sh

# Exposer le port MariaDB par défaut
EXPOSE 3306

# Démarrer le serveur MariaDB au démarrage du conteneur
ENTRYPOINT [ "/etc/mysql/create_db.sh" ]
