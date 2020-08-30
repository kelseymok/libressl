# LibreSSL
This Docker image contains the LibreSSL (v2.8.3) binary which is useful if your machine's OpenSSL is not the LibreSSL branch (as it is with many Mac setups).

## Quickstart
### Interactive Mode
```bash
docker run -it kb1rd/libressl:2.8.3 bash
```

### With Mounted Directories
The following assumes that there are pre-existing directories: input (containing files to be decrypted or encrypted) and output (an empty directory which will contain your decrypted or encrypted files as a result of running a decryption/encryption command). It mounts those directories into the docker container (and are therefore mirrored on your local machine).
```bash
docker run \
    -v "SOME-FULL-PATH/input:/input" \
    -v "SOME-FULL-PATH/output:/output" \
    --entrypoint="" \
    kb1rd/libressl:2.8.3 \
    openssl enc -d -aes-256-cbc  -in /input/SOME-ENCRYPTED-FILENAME -out /output/SOME-DECRYPTED-FILENAME -pass pass:SOME-PASSWORD
```
For a full encryption and decryption example with mounted directories, see the [example directory](./example).
