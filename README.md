# Run `Watson Speech to Text` for Embed on your local computer with Docker

This is an example about, how to use `Watson Speech to Text` based on the official example documentation:[`IBM Watson Libraries for Embed`](https://www.ibm.com/docs/en/watson-libraries?topic=rc-run-docker-run).

### Step 1: Clone the example project to your local computer

```sh
git clone https://github.com/thomassuedbroecker/watson-stt-example-local-docker
cd watson-stt-example-local-docker/code
```

### Step 2: Set your `IBM_ENTITLEMENT_KEY` in the `.env` file

```sh
cat .env_template > .env
```

Edit the `.env` file.

```sh
# used as 'environment' variables
IBMCLOUD_ENTITLEMENT_KEY="YOUR_KEY"
```

### Step 3: Execute the `run-watson-stt-with-docker.sh` bash script

```sh
sh run-watson-stt-with-docker.sh
```

* Example output:

```sh
# ******
# Connect to IBM Cloud Container Image Registry: cp.icr.io/cp/ai
# ******

IBM_ENTITLEMENT_KEY: XXXX

...

# ******
# Connect to IBM Cloud Container Image Registry: cp.icr.io/cp/ai
# ******

[+] Building 181.3s (14/21)                                                                                      
 => [runtime 1/1] FROM cp.icr.io/cp/ai/watson-tts-runtime:1.1.0@sha256:44c3e80bfbc4c539bb17556e9e764a073  178.1s
 ...
 [+] Building 543.6s (14/21)                                                                              ...      
 => => sha256:2daf64cad6c98a23301bc1880448faea6f94b29ee06b32e8ba21f3d8ef997ffb 551.55MB / 777.81MB        540.4s
 [+] Building 1042.2s (17/23)                                                                              ...     
 => => sha256:6694f134430355d7c78923b5c001f71cae8f67c9c03147137f2882d605211cec 7.34MB / 8.85MB           1039.0s
 ... 
  => [model_cache 4/4] RUN prepare_models.sh                                                                58.7s
 => => # Waiting for server to initialize models                                                                
 => => # Waiting for server to initialize models                                                                
 => => # Waiting for server to initialize models

...

# ******
# Run STT
# ******

# Run a custom container based on runtime and imported models
# custom-watson-stt-image:1.0.0

"INFO: Will download the following models defined in group default in catalog b'var/catalog.json' : ['en-US_Multimedia', 'es-LA_Telephony']"
"INFO: All 6 models files ext
 
...

```

### Step 4: List models

```sh
curl "http://localhost:1080/speech-to-text/api/v1/models"
```

* Example output:

```json
{
   "models": [
      {
         "name": "en-US_Multimedia",
         "rate": 16000,
         "language": "en-US",
         "description": "US English multimedia model for broadband audio (16kHz or more)",
         "supported_features": {
            "custom_acoustic_model": false,
            "custom_language_model": true,
            "low_latency": true,
            "speaker_labels": true
         },
         "url": "http://localhost:1080/speech-to-text/api/v1/models/en-US_Multimedia"
      },
      {
         "name": "es-LA_Telephony",
         "rate": 8000,
         "language": "es-LA",
         "description": "Latin American Spanish telephony model for narrowband audio (8kHz)",
         "supported_features": {
            "custom_acoustic_model": false,
            "custom_language_model": true,
            "low_latency": true,
            "speaker_labels": true
         },
         "url": "http://localhost:1080/speech-to-text/api/v1/models/es-LA_Telephony"
      }
   ]
}
```

### Step 5: Download an example audio in flac format

```sh
curl "https://github.com/watson-developer-cloud/doc-tutorial-downloads/raw/master/speech-to-text/0001.flac" \
  -sLo example.flac
```

### Step 6: Verify the audio

```sh
curl "http://localhost:1080/speech-to-text/api/v1/recognize" \
  --header "Content-Type: audio/flac" \
  --data-binary @example.flac
```

* Example output:

```json
{
   "result_index": 0,
   "results": [
      {
         "final": true,
         "alternatives": [
            {
               "transcript": "several tornadoes touched down as a line of severe thunderstorms swept through colorado on sunday ",
               "confidence": 0.99
            }
         ]
      }
   ]
}
```

### Used API commands:

* We list the models [v1/speech-to-text/api/v1/models](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-about) REST API methode and the `syntax_izumo_lang_en_stock` model.

* We verify a audio recording [speech-to-text/api/v1/recognize](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices-use)



