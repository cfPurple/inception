NGINX				:= nginx
WORDPRESS			:= wordpress
MARIADB				:= mariadb

DOCKCOMP			:= docker compose -f ./docker-compose.yml
BUILD				:= $(DOCKCOMP) build
UP					:= $(DOCKCOMP) up -d
STOP				:= $(DOCKCOMP) stop
RESTART				:= $(DOCKCOMP) restart
CREATE_DIR			:= sudo mkdir -p ~/data/wordpress_data ~/data/mariadb_data
RM_VOLUMES			:= sudo rm -fr ~/data/wordpress_data ~/data/mariadb_data
RM_ALL 				:= docker system prune -af

all: .create_volumes build up
build:
	cd srcs; $(BUILD)
up:
	cd srcs; $(UP)
restart:
	cd srcs; $(RESTART)
stop: .stop_containers
clean: stop .remove_local_dirs
fclean: clean .remove_cache
re: fclean all
.create_volumes:
	$(CREATE_DIR)
.stop_containers:
	cd srcs; $(STOP)
.remove_local_dirs:
	$(RM_VOLUMES)
.remove_cache:
	$(RM_ALL)
.PHONY: all up restart stop clean fclean re
