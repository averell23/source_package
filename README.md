Description
===========

A chef recipe with a LWRP for installing source packages. This is for straighfoward tarball installs on UNIX and UNIX-like systems.

It will do the usual

* Download
* untar
* configure
* make install

Once a package is successfully installed, it will be ignored on subsequent runs

Requirements
============

No hard requirements, but you may want to run the build_essentials cookbook on a machine where you want to compile stuff.

Attributes
==========

* **package_name** - the name of the package (name attribute)
* **package_extension** - the extension of the tarball, defaults to 'tar.gz'
* **prefix** - Installation prefix to use with configure. Defaults to '/opt/local'
* **checksum** - Checksum for the downloaded file. Default is empty.
* **download_url** - The download URL for the tarball WITHOUT the filename.
* **configure_options** - Additional options for the configure run. Default: Empty.
* **after_install** - A command that will be executed after the install was complete. Default: Empty.

Usage
=====

    ruby_from_source_source_package node.ruby_from_source.yaml_version do
      download_url "http://pyyaml.org/download/libyaml"
      prefix node.ruby_from_source.prefix
      checksum node.ruby_from_source.yaml_tarball_checksum
    end