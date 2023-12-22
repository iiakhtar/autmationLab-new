#!/bin/bash

## Set variable for clone url
#GITHUB_URL="$1"
#BRANCH_NAME="$2"
#echo "Git Url: $GITHUB_URL"
#echo "Git Branch name: $BRANCH_NAME"

cd /tests
folder_to_cleanup="playwright_repo"

if [ -d "$folder_to_cleanup" ]
then
    echo "cleaning up folder $folder_to_cleanup"
    rm -rf "$folder_to_cleanup"
else
    echo "$folder_to_cleanup does not exist."
fi

echo "Cloning Git branch..."
## Clone the Github repository
git clone --single-branch --branch main https://github.com/Harishk9697/playwright-test-suite.git /tests/playwright_repo
if [ $? -ne 0 ]; then
    echo "Command Git clone failed"
fi

echo "change directory to playwright repo"
cd /tests/playwright_repo
echo "list the files"
ls

echo "Installing npm..."
## Install dependencies
npm install
if [ $? -ne 0 ]; then
    echo "Command npm install failed"
fi

echo "Running playwright testcases..."
## RUN tests
npx playwright test
if [ $? -ne 0 ]; then
    echo "Command npx playwright test failed"
    aws s3 cp /tests/playwright_repo/playwright-report/index.html s3://tf-rf-scripts-spe-qaqc-bucket/PlaywrightReport/ && echo "Copied report to s3 bucket" || echo "Copying report to s3 bucket failed"
else
    echo "Command npx playwright test passed"
    aws s3 cp /tests/playwright_repo/playwright-report/index.html s3://tf-rf-scripts-spe-qaqc-bucket/PlaywrightReport/ && echo "Copied report to s3 bucket" || echo "Copying report to s3 bucket failed"
fi

#finally() {
#    ## Copy generated report to s3 bucket
#    aws s3 cp /tests/playwright_repo/playwright-report/index.html s3://tf-rf-scripts-spe-qaqc-bucket/PlaywrightReport/
#}