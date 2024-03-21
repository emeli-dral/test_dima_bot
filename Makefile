# данные пользователя на Docker Hub
USERNAME=UserNameDockerHub
REPO=RepositoryNameDockerHub
TAG=v1
TELEGRAM_BOT_TOKEN=1235
OPENAI_API_KEY=1234

IMAGE = $(USERNAME)/$(REPO):$(TAG)


PYTHON=python3
PIP=.venv/bin/pip
PYTHON_VENV=.venv/bin/python

# создание виртуального окружения
setup:
	@echo "Setup venv, install requirements and create .env"
	$(PYTHON) -m venv .venv
	$(PIP) install -r requirements.txt
	make create-env

# создание файла .env
create-env:
	echo "TELEGRAM_BOT_TOKEN=$(TELEGRAM_BOT_TOKEN)" > .env
	echo "OPENAI_API_KEY=$(OPENAI_API_KEY)" >> .env

# запуск приложения
run:
	@echo "Run app"
	$(PYTHON_VENV) app.py

# сборка образа
build:
	@echo "Build image for $(IMAGE)"
	docker build --platform linux/amd64 -t $(IMAGE) .

# публикация образа
push:
	@echo "Push image to $(IMAGE)"
	docker push $(IMAGE)

# очистка окружения
clean:
	@echo "Clean venv and .env"
	rm -rf .venv
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	rm -f .env