echo "Installing juju-local provider support"

#lxc is installed as a dependency of juju-local
# so skip this if its present
if [ -z `type lxc-ls`]; then
  apt-get update
  apt-get install -y juju-local
fi

# Only generate keys when they arent present
if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
    sudo -u vagrant -H ssh-keygen -t rsa -N '' -f id_rsa
fi

#Only need to bootstrap and switch to local on first boot
#if user futz around in the VM, they can destroy and rebuild
#if they dont know whats going on.
if [ ! -d /home/vagrant/.juju ]; then
    sudo -u vagrant -H juju init
    # set the admin key to vagrant
    sed -i.bak s/#\ network-bridge\:\ lxcbr0/admin-secret\:\ vagrant/ /home/vagrant/.juju/environments.yaml
    sudo -u vagrant -H juju switch local
fi

echo "=="
echo "Running test-pre-setup script"
echo "=="
sudo -u vagrant -H /bin/bash /vagrant/tests/00-setup
echo "=="
echo "running tests"
echo "=="
for test in `find /vagrant/tests -maxdepth 1 -perm -111 -type f \( ! -name "00-setup" \)`; do
    cd /vagrant
    sudo -u vagrant -H charm test -e local -v $test 
done
