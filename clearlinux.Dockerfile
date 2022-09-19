# syntax=docker/dockerfile:1

ARG BASE_IMAGE_TAG=clearlinux
FROM zhongruoyu/sandbox:${BASE_IMAGE_TAG}

ARG USERNAME

RUN <<-"EOF"
    set -e
    ssh-keygen -A
    groupadd -g 1000 "${USERNAME}"
    useradd -d "/home/${USERNAME}" -g "${USERNAME}" -m -s /usr/bin/zsh -u 1000 "${USERNAME}"
    mkdir -p /etc/sudoers.d
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" | tee "/etc/sudoers.d/${USERNAME}" >/dev/null
    echo "@includedir /etc/sudoers.d" | tee /etc/sudoers >/dev/null
EOF
VOLUME [ "/home/${USERNAME}" ]

COPY --chmod=755 <<-"EOF" /usr/local/bin/docker-entrypoint.sh
#!/bin/bash
/usr/sbin/sshd -D
EOF
CMD [ "docker-entrypoint.sh" ]
EXPOSE 22
