#!/bin/bash
# Copyright (c) Mainflux
# SPDX-License-Identifier: Apache-2.0

###
# Runs all Mainflux microservices (must be previously built and installed).
#
# Expects that PostgreSQL and needed messaging DB are alredy running.
# Additionally, MQTT microservice demands that Redis is up and running.
#
###

BUILD_DIR=../build

# Docker: Environment variables in Compose

## NginX
export MF_NGINX_HTTP_PORT=80
export MF_NGINX_SSL_PORT=443
export MF_NGINX_MQTT_PORT=1883
export MF_NGINX_MQTTS_PORT=8883

## NATS
export MF_NATS_URL=nats://nats:4222

## Redis
export MF_REDIS_TCP_PORT=6379

## Grafana
export MF_GRAFANA_PORT=3000

## Jaeger
export MF_JAEGER_PORT=6831
export MF_JAEGER_FRONTEND=16686
export MF_JAEGER_COLLECTOR=14268
export MF_JAEGER_CONFIGS=5778
export MF_JAEGER_URL=jaeger:6831

## Core Services

### Auth
export MF_AUTH_LOG_LEVEL=debug
export MF_AUTH_HTTP_PORT=8189
export MF_AUTH_GRPC_PORT=8181
export MF_AUTH_GRPC_URL=auth:8181
export MF_AUTH_GRPC_TIMEOUT=1s
export MF_AUTH_DB_PORT=5432
export MF_AUTH_DB_USER=mainflux
export MF_AUTH_DB_PASS=mainflux
export MF_AUTH_DB=auth
export MF_AUTH_SECRET=secret

### Users
export MF_USERS_LOG_LEVEL=debug
export MF_USERS_HTTP_PORT=8180
export MF_USERS_DB_PORT=5433
export MF_USERS_DB_USER=mainflux
export MF_USERS_DB_PASS=mainflux
export MF_USERS_DB=users
export MF_USERS_ADMIN_EMAIL=admin@example.com
export MF_USERS_ADMIN_PASSWORD=12345678
export MF_USERS_RESET_PWD_TEMPLATE=users.tmpl
export MF_USERS_PASS_REGEX=^.{8,}$

### Email utility
export MF_EMAIL_HOST=smtp.mailtrap.io
export MF_EMAIL_PORT=2525
export MF_EMAIL_USERNAME=18bf7f70705139
export MF_EMAIL_PASSWORD=2b0d302e775b1e
export MF_EMAIL_FROM_ADDRESS=from@example.com
export MF_EMAIL_FROM_NAME=Example
export MF_EMAIL_TEMPLATE=email.tmpl

### Token utility
export MF_TOKEN_RESET_ENDPOINT=/reset-request

### Things
export MF_THINGS_LOG_LEVEL=debug
export MF_THINGS_HTTP_PORT=8182
export MF_THINGS_AUTH_HTTP_PORT=8989
export MF_THINGS_AUTH_GRPC_PORT=8183
export MF_THINGS_AUTH_GRPC_URL=things:8183
export MF_THINGS_AUTH_GRPC_TIMEOUT=1s
export MF_THINGS_DB_PORT=5434
export MF_THINGS_DB_USER=mainflux
export MF_THINGS_DB_PASS=mainflux
export MF_THINGS_DB=things
export MF_THINGS_ES_URL=localhost:6379
export MF_THINGS_ES_PASS=
export MF_THINGS_ES_DB=0

### HTTP
export MF_HTTP_ADAPTER_PORT=8185

### MQTT
export MF_MQTT_ADAPTER_LOG_LEVEL=debug
export MF_MQTT_ADAPTER_MQTT_PORT=1883
export MF_MQTT_BROKER_PORT=1883
export MF_MQTT_ADAPTER_WS_PORT=8080
export MF_MQTT_BROKER_WS_PORT=8080
export MF_MQTT_ADAPTER_ES_DB=0
export MF_MQTT_ADAPTER_ES_PASS=

### VERNEMQ
export MF_DOCKER_VERNEMQ_ALLOW_ANONYMOUS=on
export MF_DOCKER_VERNEMQ_LOG__CONSOLE__LEVEL=error

### CoAP
export MF_COAP_ADAPTER_LOG_LEVEL=debug
export MF_COAP_ADAPTER_PORT=5683

## Addons Services
### Bootstrap
export MF_BOOTSTRAP_LOG_LEVEL=debug
export MF_BOOTSTRAP_PORT=8202
export MF_BOOTSTRAP_DB_PORT=5435
export MF_BOOTSTRAP_DB_USER=mainflux
export MF_BOOTSTRAP_DB_PASS=mainflux
export MF_BOOTSTRAP_DB=bootstrap
export MF_BOOTSTRAP_DB_SSL_MODE=disable

### Provision
export MF_PROVISION_CONFIG_FILE=/configs/config.toml
export MF_PROVISION_LOG_LEVEL=debug
export MF_PROVISION_HTTP_PORT=8190
export MF_PROVISION_ENV_CLIENTS_TLS=false
export MF_PROVISION_SERVER_CERT=
export MF_PROVISION_SERVER_KEY=
export MF_PROVISION_USERS_LOCATION=http://users:8180
export MF_PROVISION_THINGS_LOCATION=http://things:8182
export MF_PROVISION_USER=
export MF_PROVISION_PASS=
export MF_PROVISION_API_KEY=
export MF_PROVISION_CERTS_SVC_URL=http://certs:8204
export MF_PROVISION_X509_PROVISIONING=false
export MF_PROVISION_BS_SVC_URL=http://bootstrap:8202/things
export MF_PROVISION_BS_SVC_WHITELIST_URL=http://bootstrap:8202/things/state
export MF_PROVISION_BS_CONFIG_PROVISIONING=true
export MF_PROVISION_BS_AUTO_WHITELIST=true
export MF_PROVISION_BS_CONTENT=
export MF_PROVISION_CERTS_RSA_BITS=4096
export MF_PROVISION_CERTS_HOURS_VALID=2400h

# Certs
export MF_CERTS_LOG_LEVEL=debug
export MF_CERTS_HTTP_PORT=8204
export MF_CERTS_DB_HOST=certs-db
export MF_CERTS_DB_PORT=5436
export MF_CERTS_DB_USER=mainflux
export MF_CERTS_DB_PASS=mainflux
export MF_CERTS_DB=certs
export MF_CERTS_DB_SSL_MODE=
export MF_CERTS_DB_SSL_CERT=
export MF_CERTS_DB_SSL_KEY=
export MF_CERTS_DB_SSL_ROOT_CERT=
export MF_CERTS_ENCRYPT_KEY=
export MF_CERTS_CLIENT_TLS=
export MF_CERTS_CA_CERTS=
export MF_CERTS_SERVER_CERT=
export MF_CERTS_SERVER_KEY=
export MF_SDK_BASE_URL=http://172.17.0.1
export MF_SDK_THINGS_PREFIX=
export MF_CERTS_SIGN_CA_PATH=/etc/ssl/certs/ca.crt
export MF_CERTS_SIGN_CA_KEY_PATH=/etc/ssl/certs/ca.key
export MF_CERTS_SIGN_HOURS_VALID=2048h
export MF_CERTS_SIGN_RSA_BITS=2048
export MF_CERTS_VAULT_HOST=http://vault:8200


### Vault
export MF_VAULT_HOST=vault
export MF_VAULT_PORT=8200
export MF_VAULT_UNSEAL_KEY_1=
export MF_VAULT_UNSEAL_KEY_2=
export MF_VAULT_UNSEAL_KEY_3=
export MF_VAULT_TOKEN=
export MF_VAULT_CA_NAME=mainflux
export MF_VAULT_CA_ROLE_NAME=mainflux
export MF_VAULT_PKI_PATH=pki
export MF_VAULT_PKI_INT_PATH=pki_int
export MF_VAULT_CA_CN=mainflux.com
export MF_VAULT_CA_OU='Mainflux Cloud'
export MF_VAULT_CA_O='Mainflux Labs'
export MF_VAULT_CA_C=Serbia
export MF_VAULT_CA_L=Belgrade

### LoRa
export MF_LORA_ADAPTER_LOG_LEVEL=debug
export MF_LORA_ADAPTER_MESSAGES_URL=tcp://lora.mqtt.mainflux.io:1883
export MF_LORA_ADAPTER_HTTP_PORT=8187
export MF_LORA_ADAPTER_ROUTE_MAP_URL=localhost:6379
export MF_LORA_ADAPTER_ROUTE_MAP_PASS=
export MF_LORA_ADAPTER_ROUTE_MAP_DB=0

### OPC-UA
export MF_OPCUA_ADAPTER_HTTP_PORT=8188
export MF_OPCUA_ADAPTER_LOG_LEVEL=debug
export MF_OPCUA_ADAPTER_POLICY=
export MF_OPCUA_ADAPTER_MODE=
export MF_OPCUA_ADAPTER_CERT_FILE=
export MF_OPCUA_ADAPTER_KEY_FILE=
export MF_OPCUA_ADAPTER_ROUTE_MAP_URL=localhost:6379
export MF_OPCUA_ADAPTER_ROUTE_MAP_PASS=
export MF_OPCUA_ADAPTER_ROUTE_MAP_DB=0
export MF_OPCUA_ADAPTER_EVENT_CONSUMER=opcua

### Cassandra Writer
export MF_CASSANDRA_WRITER_LOG_LEVEL=debug
export MF_CASSANDRA_WRITER_PORT=8902
export MF_CASSANDRA_WRITER_DB_PORT=9042
export MF_CASSANDRA_WRITER_DB_CLUSTER=mainflux-cassandra
export MF_CASSANDRA_WRITER_DB_KEYSPACE=mainflux
export MF_CASSANDRA_WRITER_CONTENT_TYPE=application/senml+json
export MF_CASSANDRA_WRITER_TRANSFORMER=senml

### Cassandra Reader
export MF_CASSANDRA_READER_LOG_LEVEL=debug
export MF_CASSANDRA_READER_PORT=8903
export MF_CASSANDRA_READER_DB_PORT=9042
export MF_CASSANDRA_READER_DB_CLUSTER=mainflux-cassandra
export MF_CASSANDRA_READER_DB_KEYSPACE=mainflux
export MF_CASSANDRA_READER_SERVER_CERT=
export MF_CASSANDRA_READER_SERVER_KEY=

### InfluxDB
export MF_INFLUXDB_PORT=8086
export MF_INFLUXDB_DB=mainflux
export MF_INFLUXDB_ADMIN_USER=mainflux
export MF_INFLUXDB_ADMIN_PASSWORD=mainflux
export MF_INFLUXDB_HTTP_AUTH_ENABLED=true

### InfluxDB Writer
export MF_INFLUX_WRITER_LOG_LEVEL=debug
export MF_INFLUX_WRITER_PORT=8900
export MF_INFLUX_WRITER_BATCH_SIZE=5000
export MF_INFLUX_WRITER_BATCH_TIMEOUT=5
export MF_INFLUX_WRITER_GRAFANA_PORT=3001
export MF_INFLUX_WRITER_CONTENT_TYPE=application/senml+json
export MF_INFLUX_WRITER_TRANSFORMER=senml

### InfluxDB Reader
export MF_INFLUX_READER_LOG_LEVEL=debug
export MF_INFLUX_READER_PORT=8905
export MF_INFLUX_READER_SERVER_KEY=
export MF_INFLUX_READER_SERVER_CERT=

### MongoDB Writer
export MF_MONGO_WRITER_LOG_LEVEL=debug
export MF_MONGO_WRITER_PORT=8901
export MF_MONGO_WRITER_DB=mainflux
export MF_MONGO_WRITER_DB_PORT=27017
export MF_MONGO_WRITER_CONTENT_TYPE=application/senml+json
export MF_MONGO_WRITER_TRANSFORMER=senml

### MongoDB Reader
export MF_MONGO_READER_LOG_LEVEL=debug
export MF_MONGO_READER_PORT=8904
export MF_MONGO_READER_DB=mainflux
export MF_MONGO_READER_DB_PORT=27017
export MF_MONGO_READER_SERVER_CERT=
export MF_MONGO_READER_SERVER_KEY=

### Postgres Writer
export MF_POSTGRES_WRITER_LOG_LEVEL=debug
export MF_POSTGRES_WRITER_PORT=9104
export MF_POSTGRES_WRITER_DB_PORT=5432
export MF_POSTGRES_WRITER_DB_USER=mainflux
export MF_POSTGRES_WRITER_DB_PASS=mainflux
export MF_POSTGRES_WRITER_DB=mainflux
export MF_POSTGRES_WRITER_DB_SSL_MODE=disable
export MF_POSTGRES_WRITER_DB_SSL_CERT=""
export MF_POSTGRES_WRITER_DB_SSL_KEY=""
export MF_POSTGRES_WRITER_DB_SSL_ROOT_CERT=""
export MF_POSTGRES_WRITER_CONTENT_TYPE=application/senml+json
export MF_POSTGRES_WRITER_TRANSFORMER=senml

### Postgres Reader
export MF_POSTGRES_READER_LOG_LEVEL=debug
export MF_POSTGRES_READER_PORT=9204
export MF_POSTGRES_READER_CLIENT_TLS=false
export MF_POSTGRES_READER_CA_CERTS=""
export MF_POSTGRES_READER_DB_PORT=5432
export MF_POSTGRES_READER_DB_USER=mainflux
export MF_POSTGRES_READER_DB_PASS=mainflux
export MF_POSTGRES_READER_DB=mainflux
export MF_POSTGRES_READER_DB_SSL_MODE=disable
export MF_POSTGRES_READER_DB_SSL_CERT=""
export MF_POSTGRES_READER_DB_SSL_KEY=""
export MF_POSTGRES_READER_DB_SSL_ROOT_CERT=""

### Twins
export MF_TWINS_LOG_LEVEL=debug
export MF_TWINS_HTTP_PORT=9021
export MF_TWINS_SERVER_CERT=""
export MF_TWINS_SERVER_KEY=""
export MF_TWINS_DB=mainflux-twins
export MF_TWINS_DB_HOST=twins-db
export MF_TWINS_DB_PORT=27018
export MF_TWINS_SINGLE_USER_EMAIL=""
export MF_TWINS_SINGLE_USER_TOKEN=""
export MF_TWINS_CLIENT_TLS=""
export MF_TWINS_CA_CERTS=""
export MF_TWINS_CHANNEL_ID=
export MF_TWINS_CACHE_URL=es-redis:6379
export MF_TWINS_CACHE_PASS=
export MF_TWINS_CACHE_DB=0

### SMTP Notifier
export MF_SMTP_NOTIFIER_PORT=8906
export MF_SMTP_NOTIFIER_LOG_LEVEL=debug
export MF_SMTP_NOTIFIER_DB_PORT=5432
export MF_SMTP_NOTIFIER_DB_USER=mainflux
export MF_SMTP_NOTIFIER_DB_PASS=mainflux
export MF_SMTP_NOTIFIER_DB=subscriptions
export MF_SMTP_NOTIFIER_TEMPLATE=smtp-notifier.tmpl

# Docker image tag
export MF_RELEASE_TAG=latest


# Kill all mainflux-* stuff
function cleanup {
    pkill mainflux
    pkill nats
}

###
# NATS
###
nats-server &
counter=1
until fuser 4222/tcp 1>/dev/null 2>&1;
do
    sleep 0.5
    ((counter++))
    if [ ${counter} -gt 10 ]
    then
        echo "NATS failed to start in 5 sec, exiting"
        exit 1
    fi
    echo "Waiting for NATS server"
done

###
# AUTH
###
MF_AUTH_LOG_LEVEL=debug MF_AUTH_HTTP_PORT=8189 MF_AUTH_GRPC_PORT=8181 MF_AUTH_DB_PORT=5432 MF_AUTH_DB_USER=mainflux MF_AUTH_DB_PASS=mainflux MF_AUTH_DB=auth MF_AUTH_SECRET=secret $BUILD_DIR/mainflux-auth &

###
# Users
###
MF_USERS_LOG_LEVEL=debug MF_USERS_ADMIN_EMAIL=admin@mainflux.com MF_USERS_ADMIN_PASSWORD=12345678 MF_EMAIL_TEMPLATE=../docker/templates/users.tmpl $BUILD_DIR/mainflux-users &

###
# Things
###
MF_THINGS_LOG_LEVEL=info MF_THINGS_HTTP_PORT=8182 MF_THINGS_AUTH_GRPC_PORT=8183 MF_THINGS_AUTH_HTTP_PORT=8989 $BUILD_DIR/mainflux-things &

###
# HTTP
###
# MF_HTTP_ADAPTER_LOG_LEVEL=info MF_HTTP_ADAPTER_PORT=8185 MF_THINGS_AUTH_GRPC_URL=localhost:8183 $BUILD_DIR/mainflux-http &

###
# MQTT
###
# MF_MQTT_ADAPTER_LOG_LEVEL=info MF_THINGS_AUTH_GRPC_URL=localhost:8183 $BUILD_DIR/mainflux-mqtt &

###
# CoAP
###
# MF_COAP_ADAPTER_LOG_LEVEL=info MF_COAP_ADAPTER_PORT=5683 MF_THINGS_AUTH_GRPC_URL=localhost:8183 $BUILD_DIR/mainflux-coap &

trap cleanup EXIT

while : ; do sleep 1 ; done
