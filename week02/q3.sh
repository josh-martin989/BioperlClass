#!/bin/sh

for i in `ls ~/project/html | xargs printf "$HOME/project/html/%s\n" ; ls ~/project/cgi | xargs printf "$HOME/project/cgi/%s\n"` ;
        do
	filename=`echo "$i" | perl -e '$input=<STDIN>;chomp;$input=~/[\d\D]+\/([\d\D]+)$/;print $1;'`
	if [ "$i" -nt ~/public_html/${filename} ];
		then
        	cp $i ~/public_html/
	fi

done
