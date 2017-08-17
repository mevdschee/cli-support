#!/bin/bash
#
# on the client run:
#     ./nc.sh user@hostname
# on the server run:
#     nc 0 6000
#
PORT=6000
SESSION=support
which nc >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'Cannot find nc'
  exit 1;
fi
src_dir="${1:?Usage $0 [user@hostname]}"
if [ -e /tmp/$SESSION ]; then
  rm /tmp/$SESSION
fi
mkfifo /tmp/$SESSION
ssh -R $PORT:localhost:$PORT -N $@ &
PID_SSH=$!
cat /tmp/$SESSION | tee /dev/stderr | bash -li 2>&1 | tee /dev/stderr | nc -l localhost $PORT > /tmp/$SESSION
kill $PID_SSH
rm /tmp/$SESSION
