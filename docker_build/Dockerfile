FROM python:3.11-alpine

RUN apk add --update --no-cache
RUN apk add curl graphviz gcc libc-dev libffi-dev ttf-freefont coreutils inotify-tools nano tzdata

RUN echo "alias ll='ls -allh'" >> /etc/profile.d/alias-ll.sh

RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip3 install diagrams

ADD "diagrams-scripts" "/diagrams-scripts"

CMD ["/bin/sh", "/diagrams-scripts/files-monitor.sh"]
#ENTRYPOINT ["sleep", "infinity"]
