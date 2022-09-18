# syntax=docker/dockerfile:1

ARG BASE_IMAGE_TAG=archlinux
FROM zhongruoyu/sandbox:${BASE_IMAGE_TAG}

RUN <<-"EOF"
    set -e
    ssh-keygen -A
    groupadd -g 1000 ruoyu
    useradd -d /home/ruoyu -g ruoyu -m -s /usr/bin/zsh -u 1000 ruoyu
    echo "ruoyu ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ruoyu
EOF
VOLUME [ "/home/ruoyu" ]

COPY --chmod=755 <<-"EOF" /usr/local/bin/docker-entrypoint.sh
#!/bin/bash
/usr/sbin/sshd -D
EOF
CMD [ "docker-entrypoint.sh" ]
EXPOSE 22
