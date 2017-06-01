#!/bin/sh -e
eval $(grep '^ARG ' Dockerfile | cut -f 1 -d ' ' --complement)

PAPER_SHA512="$(curl -L "${PAPER_URL}" | sha512sum -b | cut -f 1 -d ' ')"

sed -i "s,PAPER_SHA512=.\+\?,PAPER_SHA512=${PAPER_SHA512},g" Dockerfile*
