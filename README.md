# reverse-shell.sh

This is a shell script that allows you to offer remote linux support to somebody who is behind a NAT over SSH. 
It is not really a reverse shell as it allows the user that requests the support to always connect and wait
for the person providing support to act second.

For the netcat version (almost no requirements):

    on the client run:
      ./nc.sh user@hostname
    on the server run:
      nc 0 6000

For the socat version (requires socat and screen):

    on the client run:
      ./socat.sh user@hostname
    on the server run:
      socat file:`tty`,raw,echo=0 tcp-connect:localhost:6000

This last version should be preferred as it shares the session and both parties can type.
