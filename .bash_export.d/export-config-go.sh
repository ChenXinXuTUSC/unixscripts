#!/usr/bin/env bash

if command -v go > /dev/null; then
    gohome=$(cd $(dirname $(readlink -f $(command -v go)))/..; pwd)
    export GOENV=${gohome}/go.env
    export GOCACHE=${gohome}/go-build
    go env -w GOPROXY=https://goproxy.io,direct
    # Set environment variable allow bypassing the proxy for selected modules
    go env -w GOPRIVATE=*.corp.example.com
    go env -w GO111MODULE=on
     
    go env -w GOPATH=${gohome}/gohome
    export PATH=${PATH}:${gohome}/gohome/bin
fi
