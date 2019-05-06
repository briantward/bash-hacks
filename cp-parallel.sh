#!/bin/bash

set -eu

# Number of parallel processes to run
PROCS=16

# Number of files to send to each process
FILES=100

if [[ -z "${1-}" || -z "${2-}" || -z "${3-}" ]]; then
    echo "Syntax: ${0} <src> <pod> <dst>"
    exit 1
fi

SCRIPT="$(realpath "${0}")"

SRC="$(realpath "${1}")"
POD="${2}"
DST="${3}"

shift 3

if [[ -z "${1-}" ]]; then
    cd "${SRC}"
    find . -type f -print0 |
        xargs -0 -n ${FILES} -r -P ${PROCS} "${SCRIPT}" "${SRC}" "${POD}" "${DST}"
else
    tar -c --verbatim-files-from -T <(for i in "${@}"; do echo "${i}"; done) |
        oc exec -i ${POD} -- tar -C "${DST}" -x
fi
