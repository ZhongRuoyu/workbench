# syntax = docker/dockerfile:1

ARG IMAGE_TAG=fedora
FROM zhongruoyu/sandbox:$IMAGE_TAG

RUN <<-"EOF"
    set -e
    ssh-keygen -A
    groupadd -g 1000 ruoyu
    useradd -d /home/ruoyu -g ruoyu -m -s /usr/bin/zsh -u 1000 ruoyu
    echo "ruoyu ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ruoyu
EOF
VOLUME [ "/home/ruoyu" ]

CMD [ "/usr/sbin/sshd", "-D" ]
EXPOSE 22
