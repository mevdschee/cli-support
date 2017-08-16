#!/bin/bash
#
# on the client run:
#     ./socat.sh user@hostname
# on the server run:
#     socat file:`tty`,raw,echo=0 tcp-connect:localhost:6000
#
PORT=6000
SESSION=support
which socat >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'Cannot find socat'
  exit 1;
fi
which tmux >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'Cannot find tmux'
  exit 1;
fi
src_dir="${1:?Usage $0 [user@hostname]}"
ssh -R $PORT:localhost:$PORT -N $@ &
PID_SSH=$!
tmux new-session -d -s $SESSION
socat system:"tmux attach -t $SESSION",pty,raw,echo=0,stderr,setsid,sigint tcp-listen:$PORT,bind=localhost,reuseaddr &
PID_SOCAT=$!
tmux attach -t $SESSION
tmux kill-session -t $SESSION >/dev/null 2>&1
kill $PID_SSH $PID_SOCAT

