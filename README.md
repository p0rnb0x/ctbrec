# ctbrec

Runs `ctbrec` as an unprivileged user within a `docker` container.

For HTTPS, you may use a `caddy` proxy.


### Usage

```
mkdir /path/to/recordings
mkdir /path/to/configs

docker run -e UID=`id -u` \
           -p 1080:1080 \
           -v /path/to/configs:/home/ctbrec/.config \
           -v /path/to/recordings:/home/ctbrec/recordings \
           -d p0rnb0x/ctbrec
```

