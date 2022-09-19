# syntax=docker/dockerfile:1

ARG BASE_IMAGE_TAG=debian
FROM zhongruoyu/sandbox:${BASE_IMAGE_TAG}

ARG USERNAME

RUN <<-"EOF"
    set -e
    ssh-keygen -A
    groupadd -g 1000 "${USERNAME}"
    useradd -d "/home/${USERNAME}" -g "${USERNAME}" -m -s /usr/bin/zsh -u 1000 "${USERNAME}"
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" | tee "/etc/sudoers.d/${USERNAME}" >/dev/null
EOF
VOLUME [ "/home/${USERNAME}" ]

COPY --chmod=755 <<-"EOF" /usr/local/bin/docker-entrypoint.sh
#!/bin/bash
service ssh start -D
EOF
CMD [ "docker-entrypoint.sh" ]
EXPOSE 22
