DOCKER = sudo docker
COMPOSE = $(DOCKER) compose -p inception -f srcs/docker-compose.yml
MARIADB_VOLUME = /home/yaysu/data/mariadb
WORDPRESS_VOLUME = /home/yaysu/data/wordpress
DEPENDENCIES = $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)

all: up

$(MARIADB_VOLUME):
	mkdir -p $(MARIADB_VOLUME)

$(WORDPRESS_VOLUME):
	mkdir -p $(WORDPRESS_VOLUME)

ps:
	$(COMPOSE) ps

images:
	$(COMPOSE) images

volumes:
	$(DOCKER) volume ls

networks:
	$(DOCKER) network ls

start: $(DEPENDENCIES)
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart: $(DEPENDENCIES)
	$(COMPOSE) restart

up: $(DEPENDENCIES)
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down --rmi all --volumes

fclean: clean
	sudo $(RM) -r /home/yaysu/data/*

prune: down fclean
	$(DOCKER) system prune -a -f

re: fclean all

.PHONY: all ps images volumes networks start stop restart up down clean fclean prune re

