# Working on Juju Charms with Vagrant

## Before you get started:
This is under heavy development. This is not a trivial effort - the current vagrantbox does not use the ubuntu cloud image boxfile. Its using a modified 14.04 alpha2 box built from veewee that weighs in at 801mb.


### Instructions on use:

Install Vagrant and VirtualBox

```
sudo apt-get install virtualbox vagrant
```
Place the Vagrant file and juju-vagrant-setup.sh in the root of your charm directory and run vagrant up

```
cd my_charm
wget https://raw.github.com/chuckbutler/juju-vagrant/master/Vagrantfile
wget https://raw.github.com/chuckbutler/juju-vagrant/master/vagrant-test-runner.sh
vagrant up
```

Vagrant will fetch the base box, import it into VirtualBox, and kick off a test execution.

The script does the following things for you:
- Setup a clean Ubuntu 14.04 server image with juju-core installed by default
- Installs the Juju Local provider
- Configures your local provider, and generates an SSH key for the vagrant user
- Installs your tests pre-setup file 00-setup (this is a convention used by charm add tests)
- Kicks off any tests to be run against the local provider, as long as they are chmod +x from the /vagrant/tests directory.

> If there are executable files in the tests directory - they will automatically be run.

### Workflow

***STOP*** If you haven't installed charm-tools on your development machine, now is the time to do so:

```
sudo apt-get install charm-tools
```

CD into your charm directory, and add the tests using charm-tools

```
charm add tests
```

hack away at your awesome amulet test, making sure you add any dependencies to 00-setup, move 00-autogen to the proper nomenclature for your test, and ensure its executable. When you're ready for test feedback from the clean container, simply run:

```
vagrant up
```
Afterwords you are free to do:

```
vagrant provision
```
your tests will be executed in place, and should be a faster run as the environment pre-setup and installation has already completed.

#### When you're done

```
vagrant destroy
```
To learn more about working with vagrant boxes, and how to fully remove the cached box, visit the awesome Vagrant [documentation on boxes](http://docs.vagrantup.com/v2/boxes.html)

***NOTE*** This is an important thing to note. If you do not want to use the alpha2 vagrant box, ensure you remove the box file from vagrant. It's 801mb so the file size is not trivial.
`vagrant box remove ubuntu-trusty-alpha2`

#### To keep the Vagrant Bits out of your VCS
add the following lines to your .bzrignore or .gitignore respectively to prevent them from being tracked in Version Control.

```
.vagrant
Vagrantfile
vagrant-test-runner.sh
```

All bug reports against the ubuntu-trusty-alpha2 BaseBox are welcome.

[chuckbutler/juju-vagrant-veewee-definitions](https://github.com/chuckbutler/juju-vagrant-veewee-definitions/issues)
