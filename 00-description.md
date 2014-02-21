# Testing Juju Charms with Vagrant

### Instructions:

Place the vagrant file in your $CHARM_DIR root. This may move at a later date, but for internal testing, just put it there and stop fighting me on this.

Also fetch the supporting juju-vagrant-setup.sh script - this is the driver behind the vagrant automation until we find a better process to execute the code. Embedding bash inline in a yaml file is supported: but the yaml parser chokes if you have #'s inline. It interprets the rest of the line as a comment regardless of scope. end. of. story.


