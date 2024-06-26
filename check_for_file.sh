#!/usr/bin/env bash

# Checking for file
readonly CONF_FILE=".conf"

if [[ -f ${CONF_FILE} ]]; then
    source "${CONF_FILE}"
else
    name="Bob"
fi

echo "${name}"

exit 0

# For folder, it would look something like this

if [[ ! -d "home/bob/git/${some_workdir}" ]]; then
    git clone ${some_url}
fi