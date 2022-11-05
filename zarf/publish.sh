#!/bin/bash
GITHUBREPO=andresbott/linux-candy

## read the version from debian package
#VERSION=$(ls out  | grep .deb |head -n 1 | cut -f 2 -d '_')
#VERSION="v$v"
#
## get the token from local fs
#TOKEN=$(cat "$HOME/.goreleaser/github-cloud-token")
#
## create release
#payload='{"tag_name":"'"$VERSION"'","target_commitish":"main","name":"'"$VERSION"'","body": "Release '"$VERSION"'","draft":false,"prerelease":false,"generate_release_notes":false}'
#response=$(curl -s \
#  -X POST \
#  -H "Accept: application/vnd.github+json" \
#  -H "Authorization: token $TOKEN" \
#  "https://api.github.com/repos/andresbott/linux-candy/releases" \
#  -d "$payload")
#
## the the release id from the response
#ID=$(jq -r '.id' <<< "$response")
##echo "relase ID: $ID"

echo "Uploading assets"

cd ./out
FILES="./*"
for f in $FILES
do
  FILENAME=$(basename "${f}")
  echo "Uploading $FILENAME to release"

  curl -s \
    -H "Authorization: token $TOKEN" \
    -H "Content-Type: $(file -b --mime-type "$FILENAME")" \
    --data-binary @"$FILENAME" \
    "https://uploads.github.com/repos/andresbott/linux-candy/releases/$ID/assets?name=$FILENAME"

done
