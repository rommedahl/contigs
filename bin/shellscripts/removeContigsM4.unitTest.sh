#!/bin/bash
## https://github.com/kward/shunit2
## http://manpages.ubuntu.com/manpages/trusty/man1/shunit2.1.html
## http://www.mikewright.me/shunit2-bash-testing.html
## https://code.tutsplus.com/tutorials/test-driving-shell-scripts--net-31487

setUp(){
	#originalPath=$PATH
	#PATH=$PWD:$PATH
	input="A	B	S	F	0	a1	a2	a3	R	b1	b2	b3
A	C	S	F	0	a1	a2	a3	R	c1	c2	c3
C	B	S	F	0	c1	c2	c2	R	b1	b2	b3"
	echo "$input" > input.test

	contigs="B"
	echo "$contigs" > contigs.test
	
	expected="A	C	S	F	0	a1	a2	a3	R	c1	c2	c3"
	echo "$expected" > expected.test
}

tearDown(){
	#PATH=$originalPath

	rm input.test
	rm contigs.test
	rm expected.test
	rm result.test
}

testsortM4fromFile(){
	removeContigsM4.sh contigs.test input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromRedirection(){
	removeContigsM4.sh contigs.test < input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromPipe(){
	cat input.test | removeContigsM4.sh contigs.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

# load shunit2
. shunit2
