#!/bin/sh

for i in `ls ~/project/html | xargs printf "$HOME/project/html/%s\n" ; ls ~/project/cgi | xargs printf "$HOME/project/cgi/%s\n"` ;
	do
	cp $i ~/public_html/

done
