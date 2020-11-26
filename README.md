# ctbrec

Runs `ctbrec` as an unprivileged user within a `docker` container.

### Usage

```bash
# The files in these volumes will be accessible (r+w)
# by the current user and the ctbrec user within docker

mkdir /path/to/recordings
mkdir /path/to/configs

# Fire up a container with proper bindings

docker run -e UID=`id -u` \
           -p 1080:1080 \
           -v /path/to/configs:/home/ctbrec/.config \
           -v /path/to/recordings:/home/ctbrec/recordings \
           -d p0rnb0x/ctbrec
```

You can also set the timezone using `-e TZ="Europe/Kiev"`.

I do not recommend using the pre-supplied certificate for HTTPS,
you may use a `caddy` proxy with your own certificate instead.

