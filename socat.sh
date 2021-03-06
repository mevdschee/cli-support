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
${1:?Usage $0 [user@hostname]}
ssh -R $PORT:localhost:$PORT -N $@ &
PID_SSH=$!
tmux new-session -d -s $SESSION
TTY1=$(tty)
set -- $(stty size) # $1 = rows $2 = columns
CMD="stty rows $1;\
     stty cols $2;\
     TTY2=\$(tty);\
     while sleep 1;\
     do\
       set -- \$(stty -F $TTY1 size);\
       stty -F \$TTY2 rows \$1;\
       stty -F \$TTY2 cols \$2;\
       kill -28 \$\$;\
     done"
socat system:"$CMD & tmux attach -t $SESSION",pty,raw,echo=0,stderr,setsid,sigint,sane\
  tcp-listen:$PORT,bind=localhost,reuseaddr &
PID_SOCAT=$!
tmux attach -t $SESSION
tmux kill-session -t $SESSION >/dev/null 2>&1
kill $PID_SSH $PID_SOCAT