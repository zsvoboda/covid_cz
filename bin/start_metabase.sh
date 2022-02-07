#!/bin/bash

export BIN_DIR="`dirname \"$0\"`"
export COVID_CZ_HOME="$( cd "${BIN_DIR}/.." && pwd )"


export MB_DB_TYPE=h2
export MB_PLUGINS_DIR=${COVID_CZ_HOME}/lib/plugins 
export MB_DB_FILE=${COVID_CZ_HOME}/demo/metabase.db
export MB_JETTY_PORT=3030

java -DMB_PLUGINS_DIR=${MB_PLUGINS_DIR} -DMB_JETTY_PORT=${MB_JETTY_PORT} -DMB_DB_FILE=${MB_DB_FILE} -jar ${COVID_CZ_HOME}/lib/metabase.jar