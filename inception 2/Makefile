## CONTAINERS ##
# Définition des noms des conteneurs
NGINX				:= nginx
WORDPRESS			:= wordpress
MARIADB				:= mariadb

## FOLDERS ##
# Définition des chemins des répertoires
SRCS				:= srcs/
REQ_DIR 			:= $(SRCS)/requirements/
MARIADB_DIR			:= $(REQ_DIR)/mariadb/
NGINX_DIR			:= $(REQ_DIR)/nginx/
TOOLS_DIR			:= $(REQ_DIR)/tools/
WORDPRESS_DIR		:= $(REQ_DIR)/wordpress/

## ENV ##
# Fichier d'environnement
ENV_FILE			:= .env

# Inclut le fichier .env
include $(SRCS)/$(ENV_FILE)

## COMMANDS ##
# Définition des commandes Docker Compose
DOCKCOMP            := docker-compose -f ./docker-compose.yml
BUILD               := $(DOCKCOMP) build
UP                  := $(DOCKCOMP) up -d
STOP                := $(DOCKCOMP) stop
RESTART             := $(DOCKCOMP) restart
CREATE_DIR          := mkdir -p home/cfelix/data/mariadb home/cfelix/data/wordpress
RM_VOLUMES          := rm -fr home/cfelix/data/mariadb home/cfelix/data/wordpress
RM_ALL              := docker system prune -af
## RULES ##
# Crée les volumes et démarre les conteneurs
all: .create_volumes build up
# Construit les conteneurs
build:
	cd $(SRCS); $(BUILD)
# Démarre les conteneurs
up:
	cd $(SRCS); $(UP)
# Redémarre les conteneurs
restart:
	cd $(SRCS); $(RESTART)
# Arrête les conteneurs
stop: .stop_containers
# Supprime les images et les volumes
clean: stop .remove_local_dirs
# Supprime toutes les images, les volumes et les données
fclean: clean .remove_cache
# Reconstruit tout
re: fclean all
.create_volumes:
	$(CREATE_DIR)
.stop_containers:
	cd $(SRCS); $(STOP)
.remove_local_dirs:
	$(RM_VOLUMES)
.remove_cache:
	$(RM_ALL)
.PHONY: all up restart log stop clean fclean re help