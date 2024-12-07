FROM debian:buster

# Install MariaDB server and client
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Give permissions on specific folders
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

# Set the working directory inside the container
RUN mkdir -p /etc/mysql
WORKDIR /etc/mysql/

# Copy the MariaDB configuration
COPY ./conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.cnf

# Copy the init DB script
COPY ./tools/create_db.sh /etc/mysql/create_db.sh
# Grant execute permissions to the init DB script
RUN chmod +x /etc/mysql/create_db.sh

# Expose the default MariaDB port
EXPOSE 3306

# Start the MariaDB server on container startup
ENTRYPOINT [ "/etc/mysql/create_db.sh" ]