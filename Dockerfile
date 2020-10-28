FROM openjdk:8-jre-alpine

RUN apk add --no-cache \
        ffmpeg \
        su-exec

COPY ctbrec-server /home/ctbrec/server
COPY entrypoint.sh /entrypoint.sh

VOLUME [ "/home/ctbrec/recordings", "/home/ctbrec/.config" ]

EXPOSE 1080

ENTRYPOINT [ "/entrypoint.sh" ]

