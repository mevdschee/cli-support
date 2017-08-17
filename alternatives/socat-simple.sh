
#!/bin/bash
#
# on the client run:
#     ./socat-simple.sh user@hostname
# on the server run:
#     socat file:`tty`,raw,echo=0 tcp-connect:localhost:6000
#
PORT=6000
which socat >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'Cannot find socat'
  exit 1;
fi
${1:?Usage $0 [user@hostname]}
ssh -R $PORT:localhost:$PORT -N $1 &
PID_SSH=$!
socat exec:'bash -li',pty,stderr,setsid,sigint,sane\
  tcp-listen:$PORT,bind=localhost,reuseaddr
kill $PID_SSH
