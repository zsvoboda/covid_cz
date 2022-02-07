#!/bin/bash

export BIN_DIR="`dirname \"$0\"`"
export COVID_CZ_HOME="$( cd "${BIN_DIR}/.." && pwd )"

cd ${COVID_CZ_HOME}/demo && jupyter notebook