#!/bin/bash

rrsync() {
    # 检查至少需要两个参数（目录）
    if [ "$#" -lt 2 ]; then
        echo "Usage: rrsync [options] <dir1> <dir2>"
        echo "Options:"
        echo "  --include=PATTERN      include matching files (same as rsync --include)"
        echo "  --exclude=PATTERN      exclude matching files (same as rsync --exclude)"
        return 1
    fi

    # 解析可选参数
    local rsync_opts=()
    local dirs=()
  
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --include=*|--exclude=*)
                rsync_opts+=("$1")
                shift
                ;;
            *)
                dirs+=("$1")
                shift
                ;;
        esac
    done

    # 检查目录数量
    if [ "${#dirs[@]}" -ne 2 ]; then
        echo "Error: Exactly two directories must be specified" >&2
        return 1
    fi

    local dir1="${dirs[0]}"
    local dir2="${dirs[1]}"

    # 防止自己同步自己（简单字符串比较）
    if [ "$dir1" = "$dir2" ]; then
        echo "Error: Cannot sync a directory with itself" >&2
        return 3
    fi

    echo "[INFO] Syncing between:"
    echo "  $dir1"
    echo "  $dir2"
    echo "[INFO] Using rsync options: ${rsync_opts[@]}"
    echo

    # 添加必要的rsync选项
    local common_opts=(-avzu --progress --human-readable)
    
    # 第一次同步：dir1 -> dir2
    echo "[PHASE 1] Syncing $dir1 -> $dir2"
    rsync "${common_opts[@]}" "${rsync_opts[@]}" "$dir1/" "$dir2/"
    sync_status=$?

    if [ $sync_status -ne 0 ]; then
        echo "Warning: [PHASE 1] encountered errors (code $sync_status)" >&2
    fi

    # 第二次同步：dir2 -> dir1
    echo
    echo "[PHASE 2] Syncing $dir2 -> $dir1"
    rsync "${common_opts[@]}" "${rsync_opts[@]}" "$dir2/" "$dir1/"
    sync_status=$?

    if [ $sync_status -ne 0 ]; then
        echo "Warning: [PHASE 2] encountered errors (code $sync_status)" >&2
    fi

    echo
    echo "[COMPLETE] Bidirectional sync finished"
    return $sync_status
}
