GRPC_OUT_PATH=app/grpc/src
GRPC_PROTOBUF_PATH=app/grpc/protos
SERVICE_NAME=alura-cook-service-boilerplate

NETWORK_NAME=alura
NETWORK_ID=$(shell docker network ls -qf "name=${NETWORK_NAME}")

.PHONY: build
build:
	@docker-compose build --pull
	$(MAKE) grpc

.PHONY: grpc
grpc:
	@if [ -n "${proto}" ]; then \
		$(eval proto:=*) \
		:; \
	fi; \

	docker-compose run --rm ${SERVICE_NAME} python -m grpc_tools.protoc -I ${GRPC_PROTOBUF_PATH} --python_out=${GRPC_OUT_PATH} --grpc_python_out=${GRPC_OUT_PATH} ${GRPC_PROTOBUF_PATH}/${proto}.proto


.PHONY: network
network:
	@if [ -n "${NETWORK_ID}" ]; then \
		echo "The ${NETWORK_NAME} network already exists. Skipping..."; \
	else \
		docker network create -d bridge ${NETWORK_NAME}; \
	fi

up:
	@docker-compose up

up-silent:
	@docker-compose up -d

down:
	@docker-compose down
