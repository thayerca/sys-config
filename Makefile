build:
	docker build -t ide --build-arg PY_VERSION=3.10 .
run:
	docker run -it ide .
