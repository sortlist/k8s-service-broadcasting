
DOCKER_REPO := fusakla
DOCKER_IMAGE_NAME := k8s-service-broadcasting
DOCKER_IMAGE_TAG := $(shell git symbolic-ref -q --short HEAD || git describe --tags --exact-match)

DOCKER_IMAGE := $(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
GOBIN ?= $(GOPATH)/bin

all: build test

golangci-lint:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(GOBIN) v1.49.0

lint:
	golangci-lint run  --timeout 3m ./...
	go mod tidy

build:
	CGO_ENABLED=0 go build

test:
	go test -race  ./...

docker: build
	docker build -t $(DOCKER_IMAGE) .

docker-publish: docker
	docker login -u $(DOCKER_LOGIN) -p $(DOCKER_PASSWORD) docker.io
	docker push $(DOCKER_IMAGE)
