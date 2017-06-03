#!/bin/bash
## https://github.com/kward/shunit2
## http://manpages.ubuntu.com/manpages/trusty/man1/shunit2.1.html
## http://www.mikewright.me/shunit2-bash-testing.html
## https://code.tutsplus.com/tutorials/test-driving-shell-scripts--net-31487

setUp(){
	#originalPath=$PATH
	#PATH=$PWD:$PATH
	input="A	B	S	F	0	a1	a2	a3	R	b1	b2	b3
C	D	S	F	0	c1	c2	c3	R	d1	d2	d3
C	D	S	F	0	c11	c22	c33	R	d11	d22	d33"
	echo "$input" > input.test

	expected="A	B	S	F	0	a1	a2	a3	R	b1	b2	b3"
	echo "$expected" > expected.test
}

tearDown(){
	#PATH=$originalPath

	rm input.test
	rm expected.test
	rm result.test
}

testsortM4fromFile(){
	removeMultiOverlapsM4.sh input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromRedirection(){
	removeMultiOverlapsM4.sh < input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromPipe(){
	cat input.test | removeMultiOverlapsM4.sh > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

# load shunit2
. shunit2
