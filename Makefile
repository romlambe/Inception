# all:
# 	@sudo apt-get -y install hostsed
# 	@sudo hostsed add 127.0.0.1 romlambe.42.fr && echo "\033[1;32m~|ADD romlambe.42.fr to /etc/hosts|~\033[0m"
# 	@sudo mkdir -p /home/romlambe/data/mariadb
# 	@sudo mkdir -p /home/romlambe/data/wordpress
# 	@sudo docker compose -f ./docker-compose.yml up -d --build

# down:
# 	@sudo hostsed rm 127.0.0.1 romlambe.42.fr && echo "\033[1;31m~|DELETE romlambe.42.fr from /etc/hosts|~\033[0m"
# 	@sudo docker compose -f ./docker-compose.yml down

# re:
# 	@sudo docker compose -f /docker-compose.yml up -d --build

# # clean:
# # 	@sudo rm -rf /home/romlambe/data/mariadb
# # 	@sudo rm -rf /home/romlambe/data/wordpress
# # 	@sudo docker stop $$(docker ps -qa);\
# # 	sudo docker rm $$(docker ps -qa);\
# # 	sudo docker rmi -f $$(docker images -qa);\
# # 	sudo docker volume rm $$(docker volume ls -q);\
# # 	sudo docker network rm $$(docker network ls -q);\

# clean:
# 	@sudo rm -rf /home/romlambe/data/mariadb
# 	@sudo rm -rf /home/romlambe/data/wordpress
# 	@echo "Stopping and removing all containers..."
# 	@sudo docker ps -qa | xargs -r sudo docker stop
# 	@sudo docker ps -qa | xargs -r sudo docker rm
# 	@echo "Removing all images..."
# 	@sudo docker images -qa | xargs -r sudo docker rmi -f
# 	@echo "Removing all volumes..."
# 	@sudo docker volume ls -q | xargs -r sudo docker volume rm
# 	@echo "Removing custom networks..."
# 	@sudo docker network ls -q | grep -v -E "bridge|host|none" | xargs -r sudo docker network rm

# .PHONY: all re down clean

all:
	@sudo apt-get -y install hostsed
	@sudo hostsed add 127.0.0.1 romlambe.42.fr && echo "\033[1;32m~|ADD romlambe.42.fr to /etc/hosts|~\033[0m"
	@sudo mkdir -p /home/romlambe/data/mariadb
	@sudo mkdir -p /home/romlambe/data/wordpress
	@sudo docker compose -f ./docker-compose.yml up -d --build

down:
	@sudo hostsed rm 127.0.0.1 romlambe.42.fr && echo "\033[1;31m~|DELETE romlambe.42.fr from /etc/hosts|~\033[0m"
	@sudo docker compose -f ./docker-compose.yml down

re:
	@sudo docker compose -f ./docker-compose.yml up -d --build

clean:
	@sudo rm -rf /home/romlambe/data/mariadb
	@sudo rm -rf /home/romlambe/data/wordpress
	@echo "Stopping and removing all containers..."
	@sudo docker ps -qa | xargs -r sudo docker stop
	@sudo docker ps -qa | xargs -r sudo docker rm
	@echo "Removing all images..."
	@sudo docker images -qa | xargs -r sudo docker rmi -f
	@echo "Removing all volumes..."
	@sudo docker volume ls -q | xargs -r sudo docker volume rm
	@echo "Removing custom networks..."
	@sudo docker network ls --filter "driver=bridge" -q | grep -v -E "bridge|host|none" | xargs -r sudo docker network rm

.PHONY: all re down clean