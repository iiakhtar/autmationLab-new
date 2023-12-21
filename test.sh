#!/bin/bash

## Set variable for clone url
#GITHUB_URL="$1"
#BRANCH_NAME="$2"
#echo "Git Url: $GITHUB_URL"
#echo "Git Branch name: $BRANCH_NAME"
set -e

folder_to_cleanup="/tests/playwright_repo"

if [ -d "$folder_to_cleanup"]; then
    echo "cleaning up folder $folder_to_cleanup"
    rm -rf "$folder_to_cleanup"
else
    echo "$folder_to_cleanup does not exist."
fi

try() {
    echo "before clone"
    ## Clone the Github repository
    git clone --single-branch --branch main https://github.com/Harishk9697/playwright-test-suite.git /tests/playwright_repo
    
    echo "change directory to playwright repo"
    cd /tests/playwright_repo

    echo "list the files"
    ls
    
    echo "Install npm"
    ## Install dependencies
    npm install
    
    echo "Run playwright testcases"
    ## RUN tests
    npx playwright test
}

catch() {
    echo "An error occured:"
    echo "$BASH_COMMAND"
    echo "$@"
}

finally() {
    
    echo "change directory"
    cd /tests

    ## Copy generated report to s3 bucket
    aws s3 cp /tests/playwright_repo/playwright-report/index.html s3://tf-rf-scripts-spe-qaqc-bucket/PlaywrightReport/
}

try
catch
finally