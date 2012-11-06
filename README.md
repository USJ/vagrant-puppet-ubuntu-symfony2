# Standalone version

Does the job of getting a quick clean and ready VM to start installing Symfony 2.
For a puppet server, better use the puppetlabs forge modules.

## Ubuntu box

* 12.04: http://files.vagrantup.com/precise32.box

## Default options

* apache vhost server name: vagrant.localhost
* apache vhost port number: 4567
* apache vhost document root: vagrant/symfony2/web

## Vagrant up

Everything should start fine. 
If using the default options:

* make an entry in your local hosts file for: 127.0.0.1 vagrant.localhost
* connect using: http://vagrant.localhost:4567

The box will have all the packages installed to meet the symfony 2 requirements.

## Install Symfony 2

* vagrant ssh 
* inside the /vagrant folder, install [composer](http://getcomposer.org/)
* install [Symfony 2](http://symfony.com/doc/current/quick_tour/the_big_picture.html) in vagrant/symfony2 (if using default options)
* update check.php, app_dev.php and others accordingly to allow your remote server ip address

Should work.

## What's crappy for now

* everything hardcoded, no arguments/options
* everything mainly in one manifest file
* to solve Symfony cache issues, apache user/group is changed to vagrant/vagrant
* it is pretty slow (demo page is ~30ms in local, ~1500ms through VM), seems to be related to VirtualBox shared folders issues: http://forum.symfony-project.org/viewtopic.php?t=52241&p=147056