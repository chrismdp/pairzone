# Pairzone

This is the gem code for pairzone. There's lots to do:

* Transfer the gem from using a server to using local ec2 keys (via fog?)
* Convert the cucumber tests to do everything locally
* Get the chef code into this repo and convert to chef-solo
* Make the pairzone gem:
** Request ec2 credentials
** Boot up an ec2 instance
** Use chef to configure it
** Upload your git repo (DONE)
** Sign in

## Working on the code

We're using github issues and pull requests. Usual score.

We hang out in #pairzone on Freenode.

### Getting set up

In order to run the features you need a user account on your machine called pairzone-auth with the following in _~/.ssh/authorized_keys:_

<pre>
command="echo bob.key" ssh-dss AAAAB3NzaC1kc3MAAACBAPD5ncLLo+X1GIkOXY9VQ8fWeFqtd7xSQvLOfANYh3u55mrL4xVrBaU8wku3WBOF8hWqmXThNspWJ9J95lKT89lpmAD2cGqWul619VR97Q31ar/xy4C6FI3RCUe8QIRffbGG8fWPHkAHmMPNnM9i7fBt4O0uqbgQ2K0WiE5EFkO/AAAAFQDmMkzSFVsYIpaIyFdYGGsB4qxiuwAAAIBQ+uMl6dePFYKazCdqNbP4uRq8IO4dcAC7dfM1cE0KQFK/OLfM2mcI2OBZksL2BT30NOPlvxoFekTsXw0O3NU0ejA0Xfbg4/mH6klpN9+X8TkO5A9EGSyZ+8n9N0hSTtW7YxK/ADDudnn3fZnp2+qrEmXvkfOZFY7RFYzQn6P6dgAAAIEAvXmzl+P4SEcWH48BEsFWkAlb2iz7xYLYa1MVN/pwxyA5DMZ8VXkRk1z2QBU4TMkCOc/e8XAt0aBPlp/L00bQPC2xVwxic6cdEg50LYS+UQQnirlOs9+lref48ksIdSThuvnkIs+T9L7SAuj/zon4xuroLQWsKtgRRS6SN0Q62t0= bob.key.pub
command="echo derek.key" ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvoEkswUJgBnwv0fH1LO4BXnN1zwC6ARLWvWmH7rhmRz0Y9YodEu7Kz7xYQUB5eWm1eOVTu+Bq6c29MzynTvRJi1WCumILDUQ29LciC9Y6A9VmVrHFoehtzqIpfsXpn1pTP+8RZCfS4Pt+yVyWzJKx1AkbT+cgi0wjAhQxnpdqMmp3kBfb1XZgi3qBz2Cm+Q8GRI3b0Xj7ahhYmMzJWS5qHn57jXsjxxYQuFMIScm2L6x+RhP1aE5Y/RBWW2xLQ3WCN252wWHFvWfKKCAMOXaSJKImdGwDnr0cIUbDyJhzbjPSPOjP1P0t05YK/cqK6t7BQBvcFPvXJCLBD7ZAO5t7w== derek.key.pub
</pre>

You will also need a 'pairzone' account to pretend to be the actual pairzone instance. This should have a similar file set up in _~/.ssh/authorized_keys:_

<pre>
ssh-dss AAAAB3NzaC1kc3MAAACBAPD5ncLLo+X1GIkOXY9VQ8fWeFqtd7xSQvLOfANYh3u55mrL4xVrBaU8wku3WBOF8hWqmXThNspWJ9J95lKT89lpmAD2cGqWul619VR97Q31ar/xy4C6FI3RCUe8QIRffbGG8fWPHkAHmMPNnM9i7fBt4O0uqbgQ2K0WiE5EFkO/AAAAFQDmMkzSFVsYIpaIyFdYGGsB4qxiuwAAAIBQ+uMl6dePFYKazCdqNbP4uRq8IO4dcAC7dfM1cE0KQFK/OLfM2mcI2OBZksL2BT30NOPlvxoFekTsXw0O3NU0ejA0Xfbg4/mH6klpN9+X8TkO5A9EGSyZ+8n9N0hSTtW7YxK/ADDudnn3fZnp2+qrEmXvkfOZFY7RFYzQn6P6dgAAAIEAvXmzl+P4SEcWH48BEsFWkAlb2iz7xYLYa1MVN/pwxyA5DMZ8VXkRk1z2QBU4TMkCOc/e8XAt0aBPlp/L00bQPC2xVwxic6cdEg50LYS+UQQnirlOs9+lref48ksIdSThuvnkIs+T9L7SAuj/zon4xuroLQWsKtgRRS6SN0Q62t0= bob.key.pub
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvoEkswUJgBnwv0fH1LO4BXnN1zwC6ARLWvWmH7rhmRz0Y9YodEu7Kz7xYQUB5eWm1eOVTu+Bq6c29MzynTvRJi1WCumILDUQ29LciC9Y6A9VmVrHFoehtzqIpfsXpn1pTP+8RZCfS4Pt+yVyWzJKx1AkbT+cgi0wjAhQxnpdqMmp3kBfb1XZgi3qBz2Cm+Q8GRI3b0Xj7ahhYmMzJWS5qHn57jXsjxxYQuFMIScm2L6x+RhP1aE5Y/RBWW2xLQ3WCN252wWHFvWfKKCAMOXaSJKImdGwDnr0cIUbDyJhzbjPSPOjP1P0t05YK/cqK6t7BQBvcFPvXJCLBD7ZAO5t7w== derek.key.pub
</pre>

On OSX you will also need to add the user account to the Sharing preference pane to allow them to log in

