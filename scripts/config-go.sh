#!/usr/bin/env bash

go env -w GOPROXY=https://goproxy.io,direct
# Set environment variable allow bypassing the proxy for selected modules
go env -w GOPRIVATE=*.corp.example.com
go env -w GO111MODULE=on

gohome=$(cd $(dirname $(readlink -f $(command -v go)))/..; pwd)

export GOENV=${gohome}/go.env
go env -w GOPATH=${gohome}/gohome
