NGINX               := nginx
WORDPRESS           := wordpress
MARIADB             := mariadb

DOCKCOMP            := cd srcs; docker compose -f docker-compose.yml
BUILD               := $(DOCKCOMP) build
UP                  := $(DOCKCOMP) up -d
STOP                := $(DOCKCOMP) stop
RESTART             := $(DOCKCOMP) restart
DOWN                := $(DOCKCOMP) down -v
CREATE_DIR          := sudo mkdir -p ~/data/wordpress_data ~/data/mariadb_data
RM_VOLUMES          := sudo rm -fr ~/data/wordpress_data ~/data/mariadb_data
RM_ALL              := docker system prune -af

all: .create_volumes build up
build:
    $(BUILD)
up:
    $(UP)

down: stop
    $(DOWN)

restart:
    $(RESTART)

stop:
    $(STOP)

clean: down
    docker container prune -f
    docker volume prune -f

fclean: clean 
    $(RM_ALL)
    $(RM_VOLUMES)

re: down clean all

.create_volumes:
    $(CREATE_DIR)

.PHONY: all up restart stop down clean fclean re
