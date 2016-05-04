# Config

About
=====

A few config files and scripts for archlinux.

The setup I used was Archlinux with Xterm and Bash, but I will try to make most
of those scripts usable for the most configuration possible.

As of now, most scripts will not run for you without modifications (Hardcoded
path for example), but an effort will be made to make them more
portable/configurable.

I also use a few scripts not written by me, those will not be present on this
repository and I'll most likely add links to those later.

Architecture
============
  .
  ├── bin
  │   │
  │   ├── scripts     Interactive scripts
  │   └── tools       Tool scripts
  │
  ├── i3              I3 config files
  │
  ├── rc              Shell config files
  │
  ├── template
  │   │
  │   ├── makefile    Template for makefiles
  │   └── other       Other templates
  │
  ├── vim             Vim config files
  │
  └── X               X config files

Usage
=====
 
Export.sh
---------
* **Directory**
First of all you should define the directory you want to use
* **Changeable exports**
Then you should take a look at the changeable exports
* **Other exports**
Those are the exports you might want to define for your own purpose a few
example have been given

Shellrc.sh
---------
While it's best to take a look at it by yourself here are the most important
command

* **cdp** Move in project directory (defined in *export.sh*) and then in sub directory
The following command:

`cdp TC src ast` will bring you to ~/Project/TC/src/ast

It's important to know that this command is quite flexible, for example :

`cdp T s a` will most likely bring you to the same directory (it complete each
argument to the first directory matching the pattern).

You can also define a
default project in **export.sh** so you can simply use `cdp`.

* **change** Change allows you to change some field in *export.sh*.

For example `change debug off` will set `FLAG\_DEBUG` to off.

* **revert** Revert allows you to ... revert the last action of change.

* **sedit** This script allows you to edit an alias corresponding to a script.

For example I have this line in *shellrc.sh* :

`alias custom=~/path/to/script.sh`

Using `sedit custom` will allow you to edit this script easily

* **vim** Vim is an alias to a script.

This script will analyze argument given to vim and
modify them to behave like this:

`vim basic_file` opens the file basic\_file.

`vim multiple file` open both multiple and file.

`vim file.` will open file matching this patern: `file.extention`, extention
  being a list of prefered format defined by `SUPPORTED_EXTENTIONS` in
 *export.sh*, if no matching file is found, it will create all files
 corresponding to the extention defined by `PRIORITY_PICKS` in *export.sh*

* **others**

There is a lot of other alias/scripts/function in this file, and while those
 are probably the most important to me, you should really take a look for
 yourself and change it to match your tastes.

More
----
As said earlier, it's best you take a look on your own in the files and modify
everything to match your taste.
