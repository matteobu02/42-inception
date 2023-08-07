NAME			=	inception
COMPOSE			=	./srcs/docker-compose.yml
DOCKER_COMPOSE	=	sudo docker-compose

all:		$(NAME)

$(NAME):	build
			sudo mkdir -p /home/mbucci/data /home/mbucci/data/wordpress /home/mbucci/data/database
			sudo chmod 777 /etc/hosts
			sudo echo "127.0.0.1 mbucci.42.fr" >> /etc/hosts
			sudo echo "127.0.0.1 www.mbucci.42.fr" >> /etc/hosts
			$(DOCKER_COMPOSE) -f $(COMPOSE) up -d

build:
			@$(DOCKER_COMPOSE) -f $(COMPOSE) build

up:
			@$(DOCKER_COMPOSE) -f $(COMPOSE) up -d

down:
			@$(DOCKER_COMPOSE) -f $(COMPOSE) down

clean:
			@$(DOCKER_COMPOSE) -f $(COMPOSE) down -v --rmi all

fclean:		clean
			sudo docker system prune --volumes --all --force
			sudo rm -rf /home/mbucci/data/
			sudo docker network prune --force

re:			fclean all

.PHONY:		all clean fclean build up down
