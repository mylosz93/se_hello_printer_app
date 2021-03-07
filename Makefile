.PHONY : test


deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

test:
	#PYTHONPATH=. py.test; \
	PYTHONPATH=. py.test --verbose -s

run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

lint:
	flake8 hello_world test

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run \
	--name hello-world-printer-dev \
	-p 5000:5000 \
	-d hello-world-printer

USERNAME=mylosz93
TAG=$(mylosz93)/hello-world-printer

docker_push: docker_build
	@docker login --username $(mylosz93) --password $$(Tymon120717); \
	docker tag hello-world-printer $(TAG); \
	docker logout;
