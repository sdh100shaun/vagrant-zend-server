# Zend Server 6 and MySQL Vagrant Box

This Vagrant setup configures an Ubuntu 12.04 (Precise) 64-bit box with Zend
Server 6 and PHP 5.4. It also configures an identical OS box with MySQL 5. 

The two boxes will come up named 'app' and 'db'.

## Quick Start

Run `vagrant up` from the `vagrant` directory, eg

    (cd vagrant; vagrant up)

## Shared Folders

The chosen shared directory is shared as `/srv/host_share/`

## Apache

Apache is configured with the MPM-ITK module with document root set to
`/srv/host_share`
