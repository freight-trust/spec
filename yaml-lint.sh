#!/bin/bash
set -e

FILES=*.yaml
for f in $FILES
do
  filename="${f%.yaml}"
  echo "Checking lint on.. $filename.yaml"
  yamllint $FILES
  # uncomment this line to delete the source file.
  # rm $f
don
