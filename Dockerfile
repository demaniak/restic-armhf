FROM container4armhf/armhf-alpine:3.6
LABEL maintainer="hs.coetzee+resticarmhf@gmail.com"
RUN apk update && apk add curl && curl -LO https://github.com/restic/restic/releases/download/v0.8.3/restic_0.8.3_linux_arm.bz2
