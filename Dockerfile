FROM container4armhf/armhf-alpine:3.6
LABEL maintainer="hs.coetzee+resticarmhf@gmail.com"
RUN apk update && apk add curl bzip2 && curl -O -L https://github.com/restic/restic/releases/download/v0.7.3/restic_0.7.3_linux_arm.bz2 && \
 bunzip2 restic_0.7.3_linux_arm.bz2 && chmod a+x restic_0.7.3_linux_arm
ENTRYPOINT ["./restic_0.7.3_linux_arm"]


