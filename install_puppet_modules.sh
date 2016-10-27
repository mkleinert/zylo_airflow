#!/bin/bash

# Exit on any errors.
set -e

echo "America/New York" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

PUPPET_INSTALL='puppet module install --module_repository http://forge.puppetlabs.com'

# install puppet modules
(puppet module list | grep puppetlabs-vcsrepo) ||
    puppet module install -v 1.3.0 puppetlabs-vcsrepo

(puppet module list | grep camptocamp-archive) ||
    puppet module install -v 0.8.1 camptocamp-archive

(puppet module list | grep puppetlabs-mysql) ||
    puppet module install puppetlabs-mysql
