# syntax=docker/dockerfile:1

ARG BASE_IMAGE_TAG=alpine
FROM zhongruoyu/sandbox:${BASE_IMAGE_TAG}

RUN <<-"EOF"
    set -e
    ssh-keygen -A
    addgroup -g 1000 ruoyu
    adduser -D -G ruoyu -h /home/ruoyu -s /bin/zsh -u 1000 ruoyu
    echo "ruoyu ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ruoyu
EOF
VOLUME [ "/home/ruoyu" ]

COPY --chmod=755 <<-"EOF" /usr/local/bin/docker-entrypoint.sh
#!/bin/bash
/usr/sbin/sshd -D
EOF
CMD [ "docker-entrypoint.sh" ]
EXPOSE 22
