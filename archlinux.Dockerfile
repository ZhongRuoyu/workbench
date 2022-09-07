# syntax = docker/dockerfile:1

ARG IMAGE_TAG=archlinux
FROM zhongruoyu/sandbox:$IMAGE_TAG

COPY --chmod=755 <<-"EOF" /usr/local/bin/docker-entrypoint.sh
#!/bin/bash
ssh-keygen -A
/usr/sbin/sshd
exec "$@"
EOF
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "bash" ]
EXPOSE 22

RUN <<-"EOF"
    set -e
    groupadd -g 1000 ruoyu
    useradd -d /home/ruoyu -g ruoyu -m -s /usr/bin/zsh -u 1000 ruoyu
    echo "ruoyu ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ruoyu
EOF
VOLUME [ "/home/ruoyu" ]
