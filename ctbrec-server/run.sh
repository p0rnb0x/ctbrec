#!/bin/sh -e

if ! [ -f "${HOME}/.config/ctbrec/server.json" ]; then
    mkdir -p "${HOME}/.config/ctbrec"
    cp "${HOME}/server/server.json" "${HOME}/.config/ctbrec/"
fi

if ! [ -f "${HOME}/server/ffmpeg/ffmpeg" ]; then
    ln -s "$(which ffmpeg)" "${HOME}/server/ffmpeg/ffmpeg"
fi

cd "${HOME}/server"
java -Xmx256m \
     -cp "ctbrec-server-4.7.13-final.jar" \
     -Dctbrec.config=server.json \
     ctbrec.recorder.server.HttpServer

