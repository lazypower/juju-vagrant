# Testing Juju Charms with Vagrant

### Notes:

Place the vagrant file in your $CHARM_DIR root. This may move at a later date, but for initial testing, just put it there and dont fight me on this.

Also fetch the supporting juju-vagrant-setup.sh script - this is the driver behind the vagrant automation until we find a better process to execute the code. Embedding bash inline in a yaml file is supported: but the yaml parser chokes if you have #'s inline. It interprets the rest of the line as a comment regardless of scope. end. of. story.


### Instructions on use:

Install Vagrant and Virtualbox

```
$ sudo apt-get install virtualbox vagrant
```
Place the Vagrant file and juju-vagrant-setup.sh in the root of your charm directory and run vagrant up

```
cd my_charm
wget https://gist.githubusercontent.com/chuckbutler/9146114/raw/Vagrantfile
wget https://gist.githubusercontent.com/chuckbutler/9146114/raw/vagrant-test-runner.sh
vagrant up
```

Vagrant will fetch the base box, import it into Virtualbox, and kick off a test execution. 

The script does the following things for you:
- Setup a clean Trusty Tahr server image with juju-core installed by default
- Installs the Juju Local provider
- Configures your local provider, and generates an SSH key for the vagrant user
- Installs your tests pre-setup file 00-setup (this is a convention used by charm add tests)
- Kicks off any tests to be run against the local provider, as long as they are chmod +x

If there are executable files in the tests directory - they will automatically be run.

### Workflow

```
charm add tests
```
hack away at your awesome amulet test, making sure you add any dependencies to 00-setup

```
vagrant up
``` 
on your first test execution. Afterwords you are free to do

```
vagrant provision
```
your tests will be executed in place, and should be a faster run as the environment pre-setup and installation has already completed.

#### When you're done

```
vagrant destroy
```


All bugreports against the basebox are welcome.

[chuckbutler/juju-vagrant-veewee-definitions](https://github.com/chuckbutler/juju-vagrant-veewee-definitions/issues)