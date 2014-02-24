# Testing Juju Charms with Vagrant

### Notes:

Place Vagrantfile and juju-test-runner.sh in the root of your Charm's directory (where config.yaml lives). **Note:** This may move at a later date. Also fetch the supporting vagrant-test-runner.sh script - this is the driver behind the vagrant automation until we find a better process to execute the code.


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

> If there are executable files in the tests directory - they will automatically be run.

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
To learn more about working with vagrant boxes, and how to fully remove the cached box, visit the awesome Vagrant [documentation on boxes](http://docs.vagrantup.com/v2/boxes.html)

#### To keep the Vagrant Bits out of your VCS
add the following lines to your .bzrignore or .gitignore respectively

```
.vagrant
Vagrantfile
vagrant-test-runner.sh
```

All bugreports against the basebox are welcome.

[chuckbutler/juju-vagrant-veewee-definitions](https://github.com/chuckbutler/juju-vagrant-veewee-definitions/issues)
