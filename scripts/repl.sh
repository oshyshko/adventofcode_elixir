#!/bin/sh

set -xue

# jump to project directory
cd "$(dirname $0)/../"

# from https://stackoverflow.com/a/45405071/107341
export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path \'.iex.history\'"

iex -S mix
