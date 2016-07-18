#!/bin/sh

for j in $(seq 1 4);
	do
	touch q1_file$j
done

mkdir -p q1_test

for i in $(seq 1 4);
	do
	mv ./q1_file$i ./q1_test/
done
