NGINX               := nginx
WORDPRESS           := wordpress
MARIADB             := mariadb

DOCKCOMP            := docker compose -f docker-compose.yml
BUILD               := $(DOCKCOMP) build
UP                  := $(DOCKCOMP) up -d
STOP                := $(DOCKCOMP) stop
RESTART             := $(DOCKCOMP) restart
DOWN                := $(DOCKCOMP) down -v
CREATE_DIR          := sudo mkdir -p ~/data/wordpress_data ~/data/mariadb_data
RM_VOLUMES          := sudo rm -fr ~/data/wordpress_data ~/data/mariadb_data
RM_ALL              := docker system prune -af

all: create_volumes build up

build:
    cd srcs; $(BUILD)

up:
    cd srcs; $(UP)

down: stop
    cd srcs; $(DOWN)

restart:
    cd srcs; $(RESTART)

stop:
    cd srcs; $(STOP)

clean: down
    docker container prune -f
    docker volume prune -f

fclean: clean
    $(RM_ALL)
    $(RM_VOLUMES)

re: down fclean all

create_volumes:
    $(CREATE_DIR)

.PHONY: all build up down restart stop clean fclean re create_volumes
