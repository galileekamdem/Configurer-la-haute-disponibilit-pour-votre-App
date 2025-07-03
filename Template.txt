#!/bin/bash -ex

# Update these three variables with values to the left of these instructions
IMAGES_BUCKET=UPDATE_WITH_IMAGES_BUCKET_NAME
INSTALLATION_BUCKET=UPDATE_WITH_INSTALLATION_BUCKET_NAME
YOUR_DEFAULT_AWS_REGION=UPDATE_WITH_ACTUAL_REGION

# Update yum
yum -y update

# installs nvm (Node Version Manager)
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
# Download and install nvm
aws s3 cp s3://$INSTALLATION_BUCKET/install.sh - | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# download and install Node.js (you may need to restart the terminal)
nvm install 20

#Install stress tool (for load balancing testing)
yum -y install stress

# Create a dedicated directory for the application
mkdir -p /var/app

# Get the app from Amazon S3
#wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/ILT-TF-100-TECESS-5/app/app.zip
# Download app from S3
aws s3 cp s3://$INSTALLATION_BUCKET/app.zip .

# Extract it into a desired folder
unzip app.zip -d /var/app/
cd /var/app/

# Configure S3 bucket details
export PHOTOS_BUCKET=$IMAGES_BUCKET

# Configure default AWS Region
export DEFAULT_AWS_REGION=$YOUR_DEFAULT_AWS_REGION

# Enable admin tools for stress testing
export SHOW_ADMIN_TOOLS=1

# Install dependencies
npm install

# Start your app
npm start
