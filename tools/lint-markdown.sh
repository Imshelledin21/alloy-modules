#!/usr/bin/env bash

source "$(pwd)/tools/includes/utils.sh"

source "./tools/includes/logging.sh"

# output the heading
heading "Agent" "Modules - Performing Markdown Linting using markdownlint"

# check to see if remark is installed
if [[ ! -f "$(pwd)"/node_modules/.bin/markdownlint-cli2 ]]; then
  emergency "markdownlint-cli2 node module is not installed, please run: make install";
fi

# determine whether or not the script is called directly or sourced
(return 0 2>/dev/null) && sourced=1 || sourced=0

statusCode=0
./node_modules/.bin/markdownlint-cli2 "**/*.md" "#node_modules" "#guides/deprecated*/**/*.md"
currentCode="$?"
# only override the statusCode if it is 0
if [[ "$statusCode" == 0 ]]; then
  statusCode="$currentCode"
fi

if [[ "$statusCode" == "0" ]]; then
  echo "no issues found"
  echo ""
fi

echo ""
echo ""

# if the script was called by another, send a valid exit code
if [[ "$sourced" == "1" ]]; then
  return "$statusCode"
else
  exit "$statusCode"
fi
