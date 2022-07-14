FROM python:3

RUN adduser user

ARG GRPC_PROTOBUF_PATH=./app/grpc/protos
ARG GRPC_OUT_PATH=./app/grpc/src

WORKDIR /app

COPY requirements.txt ./requirements.txt
RUN pip install --user --no-cache-dir -r requirements.txt

COPY --chown=user . ./

RUN python \
        -m grpc_tools.protoc \
        -I ${GRPC_PROTOBUF_PATH} \
        --python_out=${GRPC_OUT_PATH} \
        --grpc_python_out=${GRPC_OUT_PATH} \
        ${GRPC_PROTOBUF_PATH}/*.proto;

