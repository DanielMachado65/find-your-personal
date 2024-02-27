#!/bin/bash

# Crie o diretório necessário
mkdir -p tmp/pids
mkdir -p log

echo $RACK_ENV

# set default port to 9292
if [ -z "$APP_PORT" ]; then
    echo 'APP_PORT not defined, using default port 9292'
    APP_PORT=9292
fi

# set default rack env to development
if [ -z "$RACK_ENV" ]; then
    echo 'RACK_ENV not defined, using default rack env development'
    RACK_ENV=development
fi

if [ "$RACK_ENV" = "production" ]; then
    echo "Running in production mode"
else
    echo "Running in development mode"
fi

bundle exec rackup -p $APP_PORT --host '0.0.0.0' -E $RACK_ENV
