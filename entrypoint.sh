#!/bin/sh -e

UID="${UID:-9999}"
addgroup --gid "${UID}" --system ctbrec
adduser --disabled-password --gecos "" --home /home/ctbrec --ingroup ctbrec --uid "${UID}" ctbrec

export HOME=/home/ctbrec

chown -R ctbrec:ctbrec "${HOME}"
exec su-exec ctbrec "${HOME}/server/run.sh"

