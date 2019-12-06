# AWE to run jobs remotely

Having docker to run aribtrary tools and using CWL to run them is cute, but all 
we are really doing is wrapping layers around a program that is running on your laptop.

What if we could run our workflow on another computer?

This will require
*  a workflow (.cwl) specification
*  the workflow may require a docker container 
*  a job file to describe the inputs and options
*  A SERVER THAT WILL LET US RUN THESE WORKFLOWS

Ok.  So to get that last item, we will run AWE-server.  
AWE-server listens on the internet for workflow jobs, starts them as needed, and keeps
track of the outputs.

So we will take our workflow (.cwl) and our job description (job.yaml) and give these
to a remote AWE server, which can munch on our data.  We'll have to retrieve the result when it's done.


The example workflow we have is PROKKA, a prokaryotic annotation pipeline.  

There is no reason you can't download a docker image that has the PROKKA tookchain on it, but the image 
contains RNA and protein databases and is about 2Gbytes to download.

We can let our server handle storing the database (and performing the work of running the
pipeline).




