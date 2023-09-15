#!/bin/bash
exec 2>&1
set -euxo pipefail

mkdir -p frp
pushd frp

if [ ! -x frps ]; then
    wget -qOfrp.tgz https://github.com/fatedier/frp/releases/download/v0.51.3/frp_0.51.3_linux_amd64.tar.gz
    tar xf frp.tgz --strip-components=1
fi

popd
