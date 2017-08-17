# cli-support

This shell script allows you to offer remote linux command line support over SSH to your clients that are behind a NAT. 
It is comparable to a reverse shell, but it does not require the support agent to setup a listening port first.
The script allows the user to see what is executed and also allows the user to interact (in the socat version).

### Usage

The client that needs support should run:

      ./socat.sh user@hostname

You (the support agent) should run on the server:

      socat file:`tty`,raw,echo=0 tcp-connect:localhost:6000

The script shares the session in such a way that both parties can view AND type and that the client can resize the terminal.

### Installation

Execute the following commands:

    sudo apt install socat tmux
    curl https://raw.githubusercontent.com/mevdschee/cli-support/master/socat.sh -O socat.sh
    chmod 755 socat.sh
    
Now you are ready to run the client.
