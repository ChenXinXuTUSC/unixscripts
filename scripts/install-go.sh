#!/usr/bin/env bash

script_dir=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)

if command -v go > /dev/null; then
    erro "golang has been installed already..."
    return 0
fi

shopt -s nocasematch

host_os=$(uname -s)
if [[ "${host_os}" == "darwin" ]]; then
    host_os="darwin"
fi
if [[ "${host_os}" == "linux" ]]; then
    host_os="linux"
fi

host_arch=$(uname -m)
if [[ "${host_arch}" == "x86_64"* ]]; then
    host_arch="amd64"
fi
if [[ "${host_arch}" == "arm"* || "${host_arch}" == "aarch"* ]]; then
    host_arch="arm64"
fi

latest_ver=$(curl https://go.dev/dl/ | grep -oP "go[0-9]+\.[0-9]+(\.[0-9]+)?\.${host_os}-${host_arch}\.tar\.gz" | head -n 1 | grep -oP '[0-9]+\.[0-9]+(\.[0-9]+)?')

shopt -u nocasematch

if [[ ! "${latest_ver}" =~ [0-9]+\.[0-9]+(\.[0-9]+)? ]]; then
    erro "failed to fetch the latest version of golang, exit..."
    return -1
fi

pkg_suffix=""
if [ "${host_os}" == "linux" ]; then
    pkg_suffix="tar.gz"
fi
if [ "${host_os}" == "darwin" ]; then
    pkg_suffix="pkg"
fi

download_target="go${latest_ver}.${host_os}-${host_arch}.${pkg_suffix}"
info "${download_target}  will be download and install"

read -p "specify the dir prefix to download and install go:" install_prefix
if [ -z "${install_prefix}" ]; then
    warn "no dir is specified, using user's home dir..."
    install_prefix=${HOME}
else
    install_prefix=$(cd ${install_prefix}; pwd)
    info "golang will be installed to `${install_prefix}`"
fi

wget https://go.dev/dl/${download_target} -O ${install_prefix}/${download_target}
cd ${install_prefix} # as gunzip seems not providing a parameter to specify unzip location?
express_dir="go${latest_ver}.${host_os}-${host_arch}"
tar -xvzf ${download_target}

read -p "specify the location of symbolic link: " link_target
if [ ! -d $(dirname ${link_target}) ]; then
    mkdir -p $(dirname ${link_target})
fi
link_target=$(cd $(dirname ${link_target}); pwd)/$(basename ${link_target})
ln -s $(cd ./go/bin; pwd) ${link_target}

