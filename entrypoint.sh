#!/bin/sh -l


# Build mkdocs site.
echo "Building mkdocs site..."
mkdocs build
ls ./site
# Directory containing the built mkdocs site
MKDOCS_BUILD_DIR='./site'

# Temporary file paths
TEMP_SSH_PRIVATE_KEY_FILE='../private_key.pem'
RSYNC_OPTIONS="-avz --delete"

# Remote path cannot be empty
if [ -z "$6" ]; then
   echo 'Error: remote_path is empty'
   exit 1
fi

echo 'Deploying using rsync with SSH key authentication...'

# Ensure the private key file content is stored
printf "%s" "$4" >$TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE

# Sync mkdocs site to remote server
rsync $RSYNC_OPTIONS -e "ssh -o StrictHostKeyChecking=no -p $3 -i $TEMP_SSH_PRIVATE_KEY_FILE" $MKDOCS_BUILD_DIR/ $1@$2:$6

echo 'Deploy Success'

exit 0
