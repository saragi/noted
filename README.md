# noted

### Add domain:port in local

I run a lot of web servers for different projects, all of them on different ports. Generally I start with port 8000 and increment from there as I spin up new servers, but it became tiresome to remember what projects were running on which ports and what the next available port was.

/etc/hosts won't let you specify a port, but a combination of aliasing 127.0.0.1 to 127.0.0.X, forwarding ports from 8000 to 80, and adding the 127.0.0.X IP under an alias in /etc/hosts did work.

This script finds the next available value of X, aliases it with ifconfig, forwards the given port to port 80 with ipfw, and adds a new entry to /etc/hosts that aliases the IP to the domain you want.

Now I can add a server alias with sudo domain-alias funproject 8000, run the web server at 127.0.0.X:8000, and load up http://funproject/ in my browser.

(Because I needed it to work on a Mac, I couldn't use iptables. ipfw seems to work, though its manpage claims it's deprecated and pfctl is the way to go. I wasn't able to figure out pfctl, so ipfw it is.)

I've written more about this on Atomic Object's blog Spin.

domain-alias.sh
