
all:
	docker-compose -f srcs/docker-compose.yaml up -d --build

down:
	docker-compose -f srcs/docker-compose.yaml down -v
	docker-compose -f srcs/docker-compose.yaml down --rmi all

rmf:
	sudo rm -rf /home/esafouan/data/mariadb/*
	sudo rm -rf /home/esafouan/data/wordpress/*

clean: down rmf
