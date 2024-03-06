#!/bin/sh -l

# Build mkdocs site.
echo "Building mkdocs site..."
mkdocs build
ls ./site
# Directory containing the built mkdocs site
MKDOCS_BUILD_DIR='./site'

RSYNC_OPTIONS="-avz --delete"


# Remote path cannot be empty
if [ -z "$6" ]; then
   echo 'Error: remote_path is empty'
   exit 1
fi

echo 'Deploying using rsync...'

# Sync site to remote server using sshpass and rsync
rsync $RSYNC_OPTIONS --rsh="/usr/bin/sshpass -p {$10} ssh -o StrictHostKeyChecking=no -l {{$1}}" ./site  $2:$6

echo 'Deploy Success'

exit 0
