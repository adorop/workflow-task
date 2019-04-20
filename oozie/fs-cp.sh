#!/usr/bin/env bash

srcDir=$1
target=$2

hadoop fs -mkdir -p ${target}
hadoop fs -cp -f ${srcDir}/* ${target}