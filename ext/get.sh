#!/bin/bash

fn_abort()
{
    ERRCODE=$?
    echo >&2 "Error $ERRCODE executing $BASH_COMMAND on line ${BASH_LINENO[0]}"
    exit $ERRCODE
}

trap fn_abort ERR
set -o errtrace -o pipefail

fn_get()
{
    cd "$1/src"
    rm -f tmp.zip
    echo "$2"
    curl -s "$2" --output tmp.zip
    unzip -q tmp.zip
    rm -f tmp.zip
    cd "$1"
}

PWD=`pwd`
mkdir -p src

fn_get "$PWD" https://codeload.github.com/campisano/GenericMakefile/zip/master
fn_get "$PWD" https://codeload.github.com/oktal/pistache/zip/5cf1bb1996d4b66c0b9286779fd80f63c121adaf

cp -a src/GenericMakefile-master/Makefile.inc .
mv src/pistache-5cf1bb1996d4b66c0b9286779fd80f63c121adaf src/pistache_master_5cf1bb1 
