Chef setup for biodiversity portal
========

A sample chef repository to install and configure biodiv the generic biodiversity informatics platform. The platform serves the need for sourcing and aggregating biodiversity information and providing the information in the public domain. It provide open access to all biodoiversity information under the creative commons license with clear attribution to the contributor. The platform can be used for a country, region or group.  There are currently three portals running on the codebase:

* [India Biodiversity Portal](http://indiabiodiversity.org)
* [Bhutan Biodiversity Portal](http://biodiversity.bt)
* [WIKWIO Biodiversity Portal](http://portal.wikwio.org)

The biodiv platform has an well-integrated set of modules required for
biodiversity information:

* An observation module for citizen science and to crowd source biodiversity information
* A species pages module with one page for every species conforming to the TDWG standards of the Species Profile Model (SPM)
* A fully featured web-GIS module
* A document module for documents and reports
* A discussion forum

Requirements
============

## Hardware
    Quad core processor. (Tested on Intel(R) Xeon(R) CPU E3110 @ 3.00GHz)
    RAM at least 4GB 
    HDD at least 160 GB

## Platforms

* Ubuntu 14.04 LTS (64 bit recommended)

Tested on:

* Ubuntu 14.04 LTS (64 bit)

## Sudo privilege
You will need sudo privilege to install packages and biodiversity portal.

## Packages

Install in the following  order

### curl
    sudo apt-get install curl
### git
    sudo apt-get install git
### chef develepment kit
    wget http://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.3.0-1_amd64.deb
    sudo dpkg -i chefdk_0.3.0-1_amd64.deb
### chef
    sudo curl -L https://www.opscode.com/chef/install.sh | sudo bash

Usage
=====

## Clone this repository 

    git clone https://github.com/strandls/chef-biodiv.git

Change to the clone repository
   cd chef-biodiv

Edit biodiv.json to change

    - server name
    - app data dir
    - solr data dir
    - geoserver data dir

## Install chef cookbooks
    /opt/chefdk/bin/berks  vendor cookbooks/


## Setup biodoiversity portal
    sudo chef-solo -c solo.rb -j biodiv.json


Verifying the installation
=======

The services will take a while to startup after install. Wait for about 5 minutes before you begin verification.

### Check solr 

Visit 

    localhost:8080/solr

It should see solr interface.


### Check geoserver

Visit 

    localhost:8080/geoserver

It should see geoserver interface.


### Check biodiversity taxonomic nameparser

Run the following command

    sudo ps -aef | grep parserver

You should see output like so

    namepar+ 10996     1  0 18:52 ?        00:00:00 /usr/bin/ruby2.0 /usr/local/bin/parserver 

### Check biodiversity portal
Visit

    localhost:8080/biodiv

You should see the biodiv homepage.

### Check biodiversity portal access through nginx
Visit

     http://[server name  set in biodiv.json]/

You should see the biodiv homepage. 

You can login as the admin user using username: `admin` and password: `admin`. 
Additionally you could register a new user to check email notifications work.



