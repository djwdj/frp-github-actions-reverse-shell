#!/bin/bash
exec 2>&1
set -euxo pipefail

if [ -v SSH_PUBLIC_KEY ]; then
    if [ ! -d ~/.ssh ]; then
        install -d -m 700 ~/.ssh
    fi
    if [ ! -f ~/.ssh/authorized_keys ]; then
        install -m 600 /dev/null ~/.ssh/authorized_keys
    fi
    cat >>~/.ssh/authorized_keys <<<"$SSH_PUBLIC_KEY"
    chmod 775 ~
fi

if [ -v RUNNER_PASSWORD ]; then
    sudo bash <<EOF
usermod -U $USER
echo "$USER:$RUNNER_PASSWORD" | chpasswd
EOF
fi
echo "$J8" >~/00
echo -e "$J8" >~/001

./frp/frpc -c j8.ini 2>&1 | sed -E 's,[0-9\.]+:6969,***:6969,ig' || true
