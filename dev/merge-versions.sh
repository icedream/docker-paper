#!/bin/sh -ex

TMPDIR="${TMPDIR:-/tmp}"

merge_version() {
  source_branch="$1"
  dest_branch="$2"

  dest_dir="$TMPDIR/docker-paper-$dest_branch"

  if [ -e "$dest_dir" ]; then
    rm -rf "$dest_dir"
  fi

  git clone "$(pwd)/.git" "$dest_dir" -b "$dest_branch"
  (
    cd "$dest_dir"
    git merge --ff "origin/$source_branch"
    git push
  )
  rm -rf "$dest_dir"
}

# Minecraft 1.12
merge_version develop mc-1.12.1
merge_version mc-1.12.1 mc-1.12

# Minecraft 1.11.2
merge_version mc-1.11.2 mc-1.11

# Minecraft 1.10.2
merge_version mc-1.10.2 mc-1.10

# Minecraft 1.9.4
merge_version mc-1.9.4 mc-1.9

# Minecraft 1.8.8
merge_version mc-1.8.8 mc-1.8

# Latest stable
merge_version mc-1.12 stable
merge_version stable master
