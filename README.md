# Standalone version

Does the job of getting a quick clean and ready VM to start playing with Symfony 2.

## Ubuntu box

* Ubuntu Server 12.04.1 amd64 with VB 4.2.4 (will be downloaded automatically at first start)

## Default options

* apache vhost server name: myusj.localhost
* apache vhost port number: 4567
* apache vhost document root: /srv/www/myusj/public_html/web

## Vagrant up

Everything should start fine. 
If using the default options:

* make an entry in your local hosts file for: 127.0.0.1 myusj.localhost
* connect using: http://myusj.localhost:4567

The box will have all the packages installed to meet the symfony 2 requirements.

## Symfony 2

* Put the content of Symfony 2 in vagrant/public_html folder (important because the shared folder point there)
* update check.php, app_dev.php and others accordingly to allow your remote server ip address

Should work.

## What's crappy for now

* everything hardcoded, no arguments/options