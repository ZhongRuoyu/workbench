FROM zhongruoyu/sandbox:fedora

RUN \
    cd /usr/local/bin && \
    >docker-entrypoint.sh && \
    echo '#!/bin/bash' >>docker-entrypoint.sh && \
    echo 'ssh-keygen -A' >>docker-entrypoint.sh && \
    echo '/usr/sbin/sshd' >>docker-entrypoint.sh && \
    echo 'exec "$@"' >>docker-entrypoint.sh && \
    chmod +x docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "bash" ]
EXPOSE 22

RUN \
    groupadd -g 1000 ruoyu && \
    useradd -d /home/ruoyu -g ruoyu -m -s /usr/bin/zsh -u 1000 ruoyu && \
    echo "ruoyu ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ruoyu
VOLUME [ "/home/ruoyu" ]
