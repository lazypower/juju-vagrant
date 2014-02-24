echo "Installing juju-local provider support"
apt-get update
apt-get install -y juju-local

if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
    sudo -u vagrant -H ssh-keygen -t rsa -N '' -f id_rsa
fi

if [ ! -d /home/vagrant/.juju ]; then
    sudo -u vagrant -H juju init
    # set the admin key to vagrant
    sed -i.bak s/#\ network-bridge\:\ lxcbr0/admin-secret\:\ vagrant/ /home/vagrant/.juju/environments.yaml
    sudo -u vagrant -H juju switch local
fi

echo "Running test-pre-setup script"
sudo -u vagrant -H /bin/bash /vagrant/tests/00-setup

echo "running tests"
for test in `find /vagrant/tests -maxdepth 1 -perm -111 -type f \( ! -name "00-setup" \)`; do
    cd /vagrant
    sudo -u vagrant -H charm test -e local -v $test 
done
