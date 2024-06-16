#!/usr/bin/env bash
# set -ex

echo "param is $1"
echo "param is $2"

range=$1
other=$2

echo "param is ${range}"
echo "param is ${other}"
pro=$(( (range + other)*32 ))
echo "${pro}"