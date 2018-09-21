#!/bin/bash

export MIX_ENV=prod
export PORT=4790

echo "Stopping old copy of app, if any..."

/home/practice/elixir-practice/_build/prod/rel/practice/bin/practice stop || true

echo "Starting app..."

/home/practice/elixir-practice/_build/prod/rel/practice/bin/practice start
