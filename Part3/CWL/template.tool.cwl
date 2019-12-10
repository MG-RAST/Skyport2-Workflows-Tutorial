#!/usr/bin/env cwl-runner
cwlVersion: v1.0

# Type of definition
#   CommandLineTool , Workflow , ExpressionTool
class:  CommandLineTool

# optional label
label: <TEXT>

# optional description/documentation
# doc: <DETAILED DESCRIPTION>

# optional hints for CWL execution
hints:
# set execution environment for baseCommand
- class: DockerRequirement
  dockerPull: mgrast/pdf2wordcloud:demo

# required, name of command line tool
baseCommand: <EXECUTABLE>

# optional
# arguments: <LIST OF CONSTANT OR DERIVED COMMAND LINE OPTIONS>

# required, input mapping
inputs:
  <INPUT OPTION NAME>:
    type: File
    doc: <DESCRIPTION>
    inputBinding:
      position: 1
  <INPUT OPTION NAME>:
    type: string
    doc: <DESCRIPTION>
    inputBinding:
      position: 2

# output mapping
outputs:
  <OUTPUT OPTION NAME>:
    type: File
    outputBinding:
      glob: <EXPECTED FILE NAME OR PATTERN>
