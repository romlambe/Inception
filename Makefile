all:
	@docker rmi -f $$(docker images -qa) 
	@docker volume rm $$(docker volume ls -q)
	@docker system prune -af