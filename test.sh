## Set variable for clone url
GITHUB_URL="$1"
BRANCH_NAME="$2"
echo "Git Url: $GITHUB_URL"
echo "Git Branch name: $BRANCH_NAME"

## Clone the Github repository
git clone --single-branch --branch $BRANCH_NAME $GITHUB_URL /tests/playwright_repo

cd /tests/playwright_repo

## RUN tests
npx playwright test

## Copy generated report to s3 bucket
aws s3 cp /tests/playwright_repo/playwright-report/index.html s3://tf-rf-scripts-spe-qaqc-bucket/PlaywrightReport/