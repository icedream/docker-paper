#!/bin/sh -e
eval $(grep '^ARG ' Dockerfile | cut -f 1 -d ' ' --complement)

((PAPER_BUILD++))

exec dev/set-version.sh $PAPER_BUILD "$@"