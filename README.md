# Overview
This project is a docker image to create a docker container with 
[JetBrains IntelliJ IDEA](https://www.jetbrains.com/idea/)
pre-installed to be used as an backend for remote developing.

# Prerequisites
* a working [Docker](http://docker.io) engine running on your Linux host

# Quick Install
* clone the project,
* add your public ssh key as `key.pub` for connecting via ssh,
* run `sh build.sh`,
* run `sh run.sh`,
* connect with
  * host: ip/domain of your Linux host
  * port: `2022`
  * username: `jetbrain`
  * key: your private ssh key
* when connected with the container:
  * run `sh start.sh` to register IntelliJ (will be removed someday)
  * clone your git project to work on (will be updated someday)
* start remote developing

# Building the image
At first you must place your public ssh key named `key.pub` inside the project
to connect to the container via ssh later.

You can either
* build the image with your [own parameters](https://docs.docker.com/engine/reference/commandline/build/),
* or type `sh build.sh` to build the image named `jetbrain`.

# Running the container
You can either
* run the container with your [own parameters](https://docs.docker.com/engine/reference/run/),
* or type `sh run.sh` to start a container of the image `jetbrain`.

# Begin developing
Start your [Gateway](https://www.jetbrains.com/remote-development/gateway/)
or start remote development [from IntelliJ](https://www.jetbrains.com/help/idea/remote-development-starting-page.html).

Create a new ssh connection with the following parameters:
* Host: The domain/ip-address of your Linux host running the container
* Port: `2022`
* Username: `jetbrain`
* Key: Your private ssh key

When you successfully connected to the container, 
open up an ssh terminal and run `sh start.sh` to register the installed IntelliJ IDEA application as installed.

Now just clone a git repository you want to work on inside the container and finally start the IDE

# Troubleshooting

## IntelliJ installation not found
When you connect with ssh to the container, Gateway/IntelliJ may not find the installed IntelliJ application.
This is because the installed IDEA is not registered as a backend. 
To fix this issue, just run `sh start.sh` and restart the ssh connection.

This bug will probably be fixed in the future.

# License and Credits
This project is licensed under the [Unlicense](https://unlicense.org).