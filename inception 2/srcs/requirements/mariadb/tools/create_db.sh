#!/bin/bash
set -e

# Démarrer le serveur MySQL en mode sécurisé
echo "Starting MySQL in safe mode..."
mysqld_safe &

# Attendre que le serveur MySQL soit prêt
echo "Waiting for MySQL to be ready..."
while ! mysqladmin ping -h "localhost" --silent; do
    sleep 1
done

# Indiquer que MySQL a démarré avec succès
echo "MYSQL HAS STARTED SUCCESSFULLY"

# Exécuter les commandes MySQL
echo "Creating database..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" || { echo "Failed to create database"; exit 1; }

echo "Creating user..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';" || { echo "Failed to create user"; exit 1; }

echo "Granting privileges..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" || { echo "Failed to grant privileges"; exit 1; }

echo "Altering root user wp..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" || { echo "Failed to alter root user"; exit 1; }

echo "Flushing privileges..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" || { echo "Failed to flush privileges"; exit 1; }

# Arrêter le serveur MySQL
echo "Shutting down MySQL..."
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown || { echo "Failed to shut down MySQL"; exit 1; }

# Démarrer MySQL en mode sécurisé
echo "Starting MySQL in safe mode..."
exec mysqld_safe