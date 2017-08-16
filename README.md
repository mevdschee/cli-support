# cli-support

This shell script allows you to offer remote linux command line support over SSH to your clients that are behind a NAT. 
It is comparable to a reverse shell, but it does not require the support agent to setup a listening port first.
The script allows the user to see what is executed and also allows the user to interact (in the socat version).

## netcat version

The client that needs support should run:

      ./nc.sh user@hostname

You (the support agent) should run on the server:

      nc 0 6000

This version has almost no requirements, but does not allow both parties to type (client can only view).

### socat version (requires socat and tmux)

The client that needs support should run:

      ./socat.sh user@hostname

You (the support agent) should run on the server:

      socat file:`tty`,raw,echo=0 tcp-connect:localhost:6000

This version should be preferred as it shares the session in such a way that both parties can view AND type.
