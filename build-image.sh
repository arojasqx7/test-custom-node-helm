#!/bin/bash 

BUILD_IMAGE_INFO_FILE_LOCATION="./build-image-info.txt"

if [[ -f "$BUILD_IMAGE_INFO_FILE_LOCATION" ]]; then 
    source $BUILD_IMAGE_INFO_FILE_LOCATION
else
    echo "Error: File location not found"
    exit 1
fi 

echo "Base Image is $BASE_IMAGE"
echo "Base Image tag is $BASE_IMAGE_TAG"

docker build --build-arg BASE_IMAGE=$BASE_IMAGE --build-arg BASE_IMAGE_TAG=$BASE_IMAGE_TAG -t test-$BASE_IMAGE-$BASE_IMAGE_TAG .