#!/bin/bash
#
# on the client run:
#     ./nc.sh user@hostname
# on the server run:
#     nc 0 6000
#
PORT=6000
which nc >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'Cannot find nc'
  exit 1;
fi
src_dir="${1:?Usage $0 [user@hostname]}"
if [ -e /tmp/mypipe ]; then
  rm /tmp/mypipe
fi
mkfifo /tmp/mypipe
ssh -R $PORT:localhost:$PORT -N $1 &
PID_SSH=$!
cat /tmp/mypipe | tee /dev/stderr | bash -li 2>&1 | tee /dev/stderr | nc -l localhost $PORT > /tmp/mypipe
kill $PID_SSH
rm /tmp/mypipe
