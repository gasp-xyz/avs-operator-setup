#!/bin/sh
# Path: run.sh

. ./.env

optIn() {
  docker run --env-file .env \
  --rm \
  --volume "${ECDSA_KEY_FILE_HOST}":/app/operator_keys/ecdsa_key.json \
  --volume "${BLS_KEY_FILE_HOST}":/app/operator_keys/bls_key.json \
  ${CLI_SERVICE_IMAGE} \
  register-operator-with-avs
}

optOut() {
  docker run --env-file .env \
    --rm \
    --volume "${ECDSA_KEY_FILE_HOST}":/app/operator_keys/ecdsa_key.json \
    --volume "${BLS_KEY_FILE_HOST}":/app/operator_keys/bls_key.json \
    ${CLI_SERVICE_IMAGE} \
    deregister-operator-with-avs
}

status() {
  docker run --env-file .env \
    --rm \
    --volume "${ECDSA_KEY_FILE_HOST}":/app/operator_keys/ecdsa_key.json \
    --volume "${BLS_KEY_FILE_HOST}":/app/operator_keys/bls_key.json \
    ${CLI_SERVICE_IMAGE} \
    print-operator-status
}

if [ "$1" = "opt-in" ]; then
  optIn
elif [ "$1" = "opt-out" ]; then
  optOut
elif [ "$1" = "status" ]; then
  status
else
  echo "Invalid command"
fi