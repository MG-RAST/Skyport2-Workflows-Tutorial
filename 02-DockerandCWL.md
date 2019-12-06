
# Running tools with CWL 

Here we will use cwltool and docker to run a toy workflow.   We will extract the words from a pdf and draw a wordcloud with these.  
This workflow has two steps; we will run the steps individually and together.  These programs will run in a docker container on your 
laptop.

If we run 

```bash
cwltool pdftotext.cwl

INFO /usr/local/bin/cwltool 1.0.20191123091325
INFO Resolved 'pdftotext.cwl' to 'file:///Users/ubuntu/Skyport2/CWL/wordcloud-tutorial/pdftotext.cwl'
usage: pdftotext.cwl [-h] --pdf PDF --text TEXT [job_order]
pdftotext.cwl: error: the following arguments are required: --pdf, --text
```

This downloads a docker (named commonworkflowlanguage/cwltool:latest) and runs cwltool.
Cwltool checks if we have everything we need to run the pdftotext tool--and don't, since it has two mandatory arguments.
Cwltool declines to start the mgrast/pdf2wordcloud:demo since it found we did not specify all of the required inputs.

Let us run pdftotext tool again, giving it arguments for the input file (demo.pdf) and the output (demo.txt):

```shell
cwltool pdftotext.cwl --pdf demo.pdf --text demo.txt
```

This time it produces loads of output:

```shell
    INFO /usr/local/bin/cwltool 1.0.20191123091325
    INFO Resolved 'pdftotext.cwl' to 'file:///Users/ubuntu/Skyport2-Workflows-Tutorial/Part3/CWL/pdftotext.cwl'
    INFO [job pdftotext.cwl] /tmp/vbx0dkp9$ docker \
        run \
        -i \
        --volume=/tmp/vbx0dkp9:/SbjxQI:rw \
        --volume=/tmp/gccrhk35:/tmp:rw \
        --volume=/Users/ubuntu/Skyport2-Workflows-Tutorial/Part3/CWL/demo.pdf:/var/lib/cwl/stgc935e0dc-56c4-4f1f-bd8e-1af67ee761f6/demo.pdf:ro \
        --workdir=/SbjxQI \
        --read-only=true \
        --user=0:0 \
        --rm \
        --env=TMPDIR=/tmp \
        --env=HOME=/SbjxQI \
        --cidfile=/tmp/41zgtg7y/20191206172536-305323.cid \
        mgrast/pdf2wordcloud:demo \
        pdftotext \
        /var/lib/cwl/stgc935e0dc-56c4-4f1f-bd8e-1af67ee761f6/demo.pdf \
        demo.txt
    INFO [job pdftotext.cwl] Max memory used: 0MiB
    INFO [job pdftotext.cwl] completed success
    {
        "extractedText": {
        "location": "file:///Users/ubuntu/Skyport2-Workflows-Tutorial/Part3/CWL/demo.txt",
        "basename": "demo.txt",
        "class": "File",
        "checksum": "sha1$b6272ceb6da71f9a1ed61069dfde46856851fb70",
        "size": 40649,
        "path": "/Users/ubuntu/Skyport2-Workflows-Tutorial/Part3/CWL/demo.txt"
        }
    }
        INFO Final process status is success
```

And one output file, demo.txt.  Now we will run the second stage, wordcloud, which turns text into an image:

```shell
cwltool wordcloud.cwl --text demo.txt 
```

Which should create wordcloud.png

So far so good, we can run tools on our local machines, and we only had to install docker.
We have prepared a tool description that runs both of these steps, going from pdf to wordcloud in one invokation:

```shell
cwltool pdf2wordcloud.cwl --pdf demo.pdf
```
This produces extracted.txt.png from the specified pdf.

Let's look at the cwl tool description:

```cwl
#!/usr/bin/env cwl-runner
cwlVersion: v1.0

class:  CommandLineTool

# optional hints for CWL execution
hints:
# set execution environment for baseCommand
- class: DockerRequirement
  dockerPull: mgrast/pdf2wordcloud:demo

# required, name of command line tool
baseCommand: pdftotext

# required, input mapping
inputs:
  pdf:
    type: File
    doc: PDF input file to extract text from
    inputBinding:
      position: 1
  text:
    type: string
    doc: Name for text output file
    inputBinding:
      position: 2

# output mapping
outputs:
  extractedText:
    type: File
    outputBinding:
      glob: $(inputs.text)
```

While the cwl description describes the tool and what it needs to run--this does not change.  But when we want to 
run our workflow on other data or with other options, we want to change the arguments.  CWL calls for a second
file, a *job file* with arguments (input files and options).

Let's look at the job file:  

```yaml
pdf:
  class: File
  path: demo.pdf
text: demo.txt
```

So we can run the above workflow with inputs specified in a file  (instead of on the command line) 

```shell
cwltool pdftotext.cwl pdftotext-job.yaml
```

Which accomplishes the same thing as pdftotext.cwl above.


