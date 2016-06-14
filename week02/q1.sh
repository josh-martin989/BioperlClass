#!/bin/sh

dir=~/proj/$1

for i in bin cgi doc etc html lib sbin src ;
	do
	mkdir -p ${dir}/$i

done
