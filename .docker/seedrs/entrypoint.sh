#!/bin/bash
set -e

rails db:setup rails db:seed

# Remove a potentially pre-existing server.pid for Rails.
rm -f /seedrs/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
