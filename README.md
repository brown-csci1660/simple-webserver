# Simple webserver container

This directory contains a `Dockerfile` to build a container that runs
a very small webserver.  The server is very simple:  it does NOT
support any server-side scripting like PHP, and is essentially only
good enough so server static files.  

You might find this webserver as a place to host files for the
project--however, **using it is not required**.  

## Starting/working with the container

This repository contains a `Dockerfile` that automatically builds the
container and a script to run it.  

### Initial setup:  build the container image

```
./run-container setup
```

### Starting the container
```
./run-container start
```
This will start a webserver and print an URL you can
use to connect to it--for details, see the next section.  

In your terminal, you should see a log of each request made to the
webserver.  To shutdown the webserver, press `Ctrl + C`.  

## Hosting files and connecting to the webserver

The webserver hosts all files in the `webroot` directory of this
repository.  For example, if you add the file `webroot/index.html`,
you can start the container and then view it at
`http://SERVER-ADDRESS/index.html`

What should `SERVER-ADDRESS` be?  The answer is a bit complicated due
to how networking works inside containers: containers run inside their
own network that is separated from the host system, and we need to do
some special logic to connect to them from the host.  We've set all
this up for you, but the key point is that the URL you use is
different depending on how you're connecting to the container:


- To connect to the webserver **from your host machine** (ie, OUTSIDE
   the container):  Use the address http://localhost:9090
    - **DO NOT use this address in exploits**:  it only works on your
      host system!

- To connect to the webserver **from another container** use the IP
   address listed for "this container's internal IP", which is printed
   when the server starts up (for example, http://172.17.0.2/index.html )
    - Note:  this address may change each time you start the
      container, so check for it each time!

## More useful container utilities

You may find the following options useful for working with the container.

### Resetting the container

To restart the container from fresh copy of the image, run:
```
./run-container --clean start
```

This will start a new container from the original image, erasing any
changes made to the container filesystem. 

Note: this doesn't affect the `webroot` directory, which is shared
with your local machine--any changes you make here are
still saved.  

### Erasing the container image

If you want to free up space and delete the container image entirely,
run:
```
./run-container clean-image
```

This deletes any containers and the image itself, (hopefully) removing
it completely from your Docker storage.  
