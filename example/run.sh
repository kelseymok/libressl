#!/usr/bin/env bash

set -ex

script_dir=$(cd "$(dirname "$0")" ; pwd -P)

password=$1
if [ -z "${password}" ]; then
  echo "Password for file encryption not set. Please choose one!"
  echo "Usage: <Password>"
  exit 1
fi

preclean() {
  rm -rf input
  rm -rf output
}

remove_container() {
  docker rm -f libressl > /dev/null || true
}

encrypt_file() {
  docker run \
      --name libressl \
      -v "${script_dir}/original:/original" \
      -v "${script_dir}/input:/input" \
      --entrypoint "" \
      libressl:2.8.3 \
      openssl enc -e -aes-256-cbc  -in /original/file-to-encrypt.txt -out /input/my-encrypted-file.enc -pass pass:${password}
  remove_container
}

decrypt_file() {
  docker run \
      --name libressl \
      -v "${script_dir}/input:/input" \
      -v "${script_dir}/output:/output" \
      --entrypoint="" \
      libressl:2.8.3 \
      openssl enc -d -aes-256-cbc  -in /input/my-encrypted-file.enc -out /output/my-decrypted-file.txt -pass pass:${password}
  remove_container
}

preclean
encrypt_file
decrypt_file

