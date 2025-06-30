DC=docker compose
YML=srcs/docker-compose.yml

all: build up

build:
	$(DC) -f $(YML) build

up:
	$(DC) -f $(YML) up -d

down:
	$(DC) -f $(YML) down

restart: down up

clean:
	$(DC) -f $(YML) down -v --remove-orphans

logs:
	$(DC) -f $(YML) logs -f
