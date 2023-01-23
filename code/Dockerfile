# Example is available on "https://www.ibm.com/docs/en/watson-libraries?topic=rc-run-docker-run"
# Model images
FROM cp.icr.io/cp/ai/watson-stt-generic-models:1.1.0 as catalog
FROM cp.icr.io/cp/ai/watson-stt-en-us-multimedia:1.1.0 as en-us-multimedia
FROM cp.icr.io/cp/ai/watson-stt-es-la-telephony:1.1.0 as es-la-telephony
# Add additional FROM statements for additional models here

# Base image for the runtime
FROM cp.icr.io/cp/ai/watson-stt-runtime:1.1.0 AS runtime

# Configure the runtime
# MODELS is a comma separated list of Model IDs
ENV MODELS=en-US_Multimedia,es-LA_Telephony
ENV DEFAULT_MODEL=en-US_Multimedia

# Copy in the catalog
# $CHUCK is already set in the base image
RUN echo "ENV: ${CHUCK}"
COPY --chown=watson:0 --from=catalog catalog.json ${CHUCK}/var/catalog.json

# Intermediate image to populate the model cache
FROM runtime as model_cache

# Copy model archives from model images
RUN sudo mkdir -p /models/pool2
COPY --chown=watson:0 --from=en-us-multimedia model/* /models/pool2/
COPY --chown=watson:0 --from=es-la-telephony model/* /models/pool2/
# For each additional model, copy the line above and update the --from

# Run script to initialize the model cache from the model archives
RUN prepare_models.sh

# Final runtime image with models baked in
FROM runtime as release

COPY --from=model_cache ${CHUCK}/var/cache/ ${CHUCK}/var/cache/