#!/bin/sh

dir=~/proj/$1

mkdir -p ${dir}/bin
mkdir -p ${dir}/cgi
mkdir -p ${dir}/doc
mkdir -p ${dir}/etc
mkdir -p ${dir}/html
mkdir -p ${dir}/lib
mkdir -p ${dir}/sbin
mkdir -p ${dir}/src
touch ${dir}/changes.txt
touch ${dir}/Makefile
