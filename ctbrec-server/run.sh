#!/bin/sh -e

if ! [ -f "${HOME}/.config/ctbrec/server.json" ]; then
    mkdir -p "${HOME}/.config/ctbrec"
    cp "${HOME}/server/server.json" "${HOME}/.config/ctbrec/"
fi

if ! [ -f "${HOME}/server/ffmpeg/ffmpeg" ]; then
    ln -s "$(which ffmpeg)" "${HOME}/server/ffmpeg/ffmpeg"
fi

cd "${HOME}/server"
java -Xmx2048m \
     -cp "ctbrec-server-3.10.6-final.jar" \
     -Dctbrec.config=server.json \
     ctbrec.recorder.server.HttpServer

