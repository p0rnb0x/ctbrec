#!/bin/sh -e

VERSION=5.2.3

if ! [ -f "${HOME}/.config/ctbrec/$VERSION/server.json" ]; then
    mkdir -p "${HOME}/.config/ctbrec/$VERSION"
    cp "${HOME}/server/server.json" "${HOME}/.config/ctbrec/$VERSION"
fi

if ! [ -f "${HOME}/server/ffmpeg/ffmpeg" ]; then
    ln -s "$(which ffmpeg)" "${HOME}/server/ffmpeg/ffmpeg"
fi

cd "${HOME}/server"
java -Xmx256m \
     -cp "ctbrec-server-$VERSION-final.jar" \
     -Dctbrec.config=server.json \
     ctbrec.recorder.server.HttpServer

