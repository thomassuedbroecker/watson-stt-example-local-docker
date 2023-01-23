#!/bin/bash

# **************** Global variables
source ./.env

# Information on c
IMAGE_REGISTRY=${IMAGE_REGISTRY:-"cp.icr.io/cp/ai"}
RUNTIME_CONTAINER_NAME=custom-watson-tts-runtime
CUSTOM_TTS_IMAGE=custom-watson-tts-image
TAG=1.0.0

# **********************************************************************************
# Functions definition
# **********************************************************************************

function connectToIBMContainerRegistry () {
    echo ""
    echo "# ******"
    echo "# Connect to IBM Cloud Container Image Registry: $IMAGE_REGISTRY"
    echo "# ******"
    echo ""
    echo "IBM_ENTITLEMENT_KEY: $IBM_ENTITLEMENT_KEY"
    echo ""
    docker login cp.icr.io --username cp --password $IBM_ENTITLEMENT_KEY
}

function buildCustomContainer () {
    echo ""
    echo "# ******"
    echo "# Connect to IBM Cloud Container Image Registry: $IMAGE_REGISTRY"
    echo "# ******"
    echo ""
    docker build . -t "$CUSTOM_TTS_IMAGE:$TAG"
}

function runTTS () {

    echo ""
    echo "# ******"
    echo "# Run TTS"
    echo "# ******"
    echo ""  
    echo "# Run a custom container based on runtime and imported models"
    echo "# $CUSTOM_TTS_IMAGE:$TAG"
    echo ""
    docker run --rm -it \
           --name $RUNTIME_CONTAINER_NAME \
           -e ACCEPT_LICENSE=true \
           -p 1080:1080 \
           "$CUSTOM_TTS_IMAGE:$TAG" 
           

}

#**********************************************************************************
# Execution
# *********************************************************************************

connectToIBMContainerRegistry

buildCustomContainer

runTTS

