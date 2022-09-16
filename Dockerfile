FROM alpine:3.13


RUN apk add --no-cache openssh
RUN apk add --no-cache python3
RUN apk add --no-cache py3-pip

RUN apk add build-base
RUN python3 -m pip install --upgrade pip
RUN pip install --quiet --no-cache-dir mkdocs
RUN pip install --quiet --no-cache-dir mkdocs-material
RUN pip install --quiet --no-cache-dir mkdocs-git-revision-date-localized-plugin
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

