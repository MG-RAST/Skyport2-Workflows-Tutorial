# Installation

We are going to ask you to install two powerful, versatile computing tools on your laptop.

Both of these are meta-tools that manage other programs.

## Docker


Install  Docker CE for your desktop from https://docs.docker.com/v17.09/engine/installation/#server

You will need to choose your operating system to get the right installer.  The installers are about 500Mb.

What does docker do?  Docker allows running commands in pre-configured *containers* that include 
programs, operating systems, and sometimes training data bundled together.  Docker manages starting
and interacting with these containers.

Why bother?  Docker lets you run linux tools on other operating systems.  Even better, docker lets
you run different linux tools in their own environments, and you can expect tools to work out of the
box without installation steps.

OSX installer
https://download.docker.com/mac/stable/Docker.dmg

Windows installer
https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe

Ubuntu install instructions
https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/#docker-ee-customers


## Common Workflow Language

The Common Workflow Language is a tooling layer that describes what resources and data tools
need to run, and what data tools produce.  This *specification* allows CWL to manage the interface
with a tool--getting the data in and getting the data out.

https://www.commonwl.org/user_guide/

Why bother?  Describing the tool at a high level can let us run the tool in different settings.
Some tools run on our local operating system, some might run in a docker container, and some
can be run on a remote server.  Most of the parts of the tool specification will remain the same,
and we can start using tools without repeating the installation, configuration, and operating
system drudgery every time.


https://github.com/common-workflow-language/cwltool/blob/master/windowsdoc.md


