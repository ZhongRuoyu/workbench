# syntax=docker/dockerfile:1

ARG IMAGE_TAG=clearlinux
FROM zhongruoyu/sandbox:$IMAGE_TAG

RUN <<-"EOF"
    set -e
    ssh-keygen -A
    groupadd -g 1000 ruoyu
    useradd -d /home/ruoyu -g ruoyu -m -s /usr/bin/zsh -u 1000 ruoyu
    mkdir -p /etc/sudoers.d
    echo "ruoyu ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ruoyu
    echo "@includedir /etc/sudoers.d" >/etc/sudoers
EOF
VOLUME [ "/home/ruoyu" ]

COPY --chmod=755 <<-"EOF" /usr/local/bin/docker-entrypoint.sh
#!/bin/bash
/usr/sbin/sshd -D
EOF
CMD [ "docker-entrypoint.sh" ]
EXPOSE 22
