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

build: .build_done

.build_done:
	$(BUILD)
	touch .build_done

up: .up_done

.up_done:
	$(UP)
	touch .up_done

down: stop
	$(DOWN)
	rm -f .up_done

restart: down
	$(RESTART)
	rm -f .up_done .build_done

stop:
	$(STOP)

clean: down
	docker container prune -f
	docker volume prune -f
	rm -f .build_done .up_done

fclean: clean 
	$(RM_ALL)
	$(RM_VOLUMES)

re: down clean all

.create_volumes: .volumes_created

.volumes_created:
	$(CREATE_DIR)
	touch .volumes_created

.PHONY: all up restart stop down clean fclean re
