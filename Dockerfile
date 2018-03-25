FROM container4armhf/armhf-alpine:3.6
LABEL maintainer="hs.coetzee+resticarmhf@gmail.com"
RUN  apk add --update --no-cache curl bzip2 ca-certificates fuse && \
 curl  -L https://github.com/restic/restic/releases/download/v0.7.3/restic_0.7.3_linux_arm.bz2 |  bunzip2 > restic  && \ 
 chmod a+x restic && \
 apk del curl bzip2
RUN mkdir /run/secrets
COPY main.sh ./main.sh
ENTRYPOINT ["./main.sh"]


