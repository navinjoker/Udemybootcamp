#!/usr/bin/env bash
# How to use:
# sh convert_notebook.sh path/to/file.ipynb

# Catch file
FILE=$1


# convert all notebooks to markdown
echo
echo Converting "$FILE" to MARKDOWN
echo
jupyter nbconvert --to markdown "$FILE"

# convert all notebooks to python scripts
echo
echo Converting "$FILE" to PYTHON
echo
jupyter nbconvert --to script "$FILE"
