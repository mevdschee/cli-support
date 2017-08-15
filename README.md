# cli-support

This shell script allows you to offer remote linux command line support over SSH to users behind a NAT. 
It is comparable to a reverse shell, but it does not require the support agent to setup a listening port first.
The script allows the user to see what is executed and also allows the user to interact (in the socat version).

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

This last version should be preferred as it shares the session in such a way that both parties can type.
