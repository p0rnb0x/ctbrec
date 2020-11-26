#!/bin/sh -e

UID="${UID:-9999}"
addgroup --gid "${UID}" --system ctbrec || true
adduser --disabled-password --gecos "" --home /home/ctbrec --ingroup ctbrec --uid "${UID}" ctbrec || true

export HOME=/home/ctbrec

chown -R ctbrec:ctbrec "/cache"
chown -R ctbrec:ctbrec "${HOME}"

exec su-exec ctbrec "${HOME}/server/run.sh"

