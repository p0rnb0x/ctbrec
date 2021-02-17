FROM alpine:3.13

RUN apk add --no-cache \
        ffmpeg \
        openjdk8-jre-base \
        su-exec \
        tzdata

COPY ctbrec-server /home/ctbrec/server
COPY entrypoint.sh /entrypoint.sh

VOLUME [ "/home/ctbrec/recordings", "/home/ctbrec/.config" ]

EXPOSE 1080 1443

ENTRYPOINT [ "/entrypoint.sh" ]

HEALTHCHECK --interval=10s --retries=3 --timeout=3s \
        CMD [ "wget", "-qSO", "/dev/null", "http://localhost:1080/static/index.html" ]
