# Zend Server 6 Vagrant Box

This Vagrant setup configures an Ubuntu 12.04 (Precise) 64-bit box with Zend
Server 6 and PHP 5.4.
and phpunit installed by pear 
It was originally forked from philBrown / vagrant-zend-server
## Quick Start

Run `vagrant up` from the `vagrant` directory, eg

    (cd vagrant; vagrant up)
    
## Forwarded Ports

* 8080 => 80 (Webapp)
* 10081 => 10081 (Zend Server Console)
* 10082 => 10082 (Zend Server HTTPS Console)

## Shared Folders

The `app` directory is shared as `/home/vagrant/app`

## Apache

Apache is configured with the MPM-ITK module with document root set to
`/home/vagrant/app`


