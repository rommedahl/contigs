#!/bin/bash
## file: tests.sh

## https://github.com/kward/shunit2
## http://manpages.ubuntu.com/manpages/trusty/man1/shunit2.1.html
## http://www.mikewright.me/shunit2-bash-testing.html
## https://code.tutsplus.com/tutorials/test-driving-shell-scripts--net-31487

setUp(){
	#originalPath=$PATH
	#PATH=$PWD:$PATH
	input="D	C	S	F	0	d1	d2	d3	R	c1	c2	c2
A	B	S	F	0	a1	a2	a3	R	b1	b2	b3
B	A	S	F	0	b1	b2	b3	R	a1	a2	a3"
	echo "$input" > input.test

	expected="A	B	S	F	0	a1	a2	a3	R	b1	b2	b3
C	D	S	F	0	c1	c2	c2	R	d1	d2	d3"
	echo "$expected" > expected.test
}

tearDown(){
	#PATH=$originalPath

	rm input.test
	rm expected.test
	rm result.test
}

testsortM4fromFile(){
	sortM4.sh input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromRedirection(){
	sortM4.sh < input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromPipe(){
	cat input.test | sortM4.sh > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

# load shunit2
. shunit2
