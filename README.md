CRITs Dependencies
==================

This repository contains some of the dependencies for CRITs. This includes any
software and libraries that cannot be acquired via normal OS package management.

# Acquiring this software

The two options to download the dependencies are to either clone the repository
or download the repo as a zipfile. If you choose to git clone it will be much
easier to update the dependencies in the future via git pull.

If you are looking for the dependencies for a specific version of CRITs, be sure
to download the proper tagged commit of the repo.

# Installing this software

Once you have downloaded or cloned the repository, you will want to run the
install_dependencies.sh script which comes with it.

`sudo ./install_dependencies.sh`

This will take care of using the OS's package management system to download some
basic packages before installing the local content.

# Building new dependencies

All of the dependencies found in the Ubuntu and RedHat directories were built
using FPM. FPM can be found here:

https://github.com/jordansissel/fpm

If you wish to update any of the packages to a newer version or introduce new
dependencies, please use FPM to build debs and rpms. Place them in the
appropriate directory and update the install_dependencies.sh script.
