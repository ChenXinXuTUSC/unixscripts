#!/usr/bin/env bash

createlink() {
    if [ "$#" -ne 2 ]; then
        echo "usage: createlink <src_pth> <dst_pth>"
        return -1
    fi

    # obtain src path and dst path
    src_path=${1}
    dst_path=${2}

    # convert to absolute path
    src_abs_path=$(realpath ${src_path})
    dst_abs_path=$(realpath ${dst_path})
    echo "try create symbolic link between ${src_abs_path} and ${dst_abs_path}"

    # check if paths exist or not
    if [ ! -e "${src_abs_path}" ]; then
        echo "${src_abs_path} not exists..."
        return -1
    fi

    if [ -e "${dst_abs_path}" ]; then
        echo "${dst_abs_path} already exists..."
        return -1
    fi

    # create soft link
    ln -s ${src_abs_path} ${dst_abs_path}
}
