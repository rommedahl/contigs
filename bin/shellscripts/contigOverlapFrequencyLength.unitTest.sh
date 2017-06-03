#!/bin/bash
## https://github.com/kward/shunit2
## http://manpages.ubuntu.com/manpages/trusty/man1/shunit2.1.html
## http://www.mikewright.me/shunit2-bash-testing.html
## https://code.tutsplus.com/tutorials/test-driving-shell-scripts--net-31487

setUp(){
	#originalPath=$PATH
	#PATH=$PWD:$PATH
	input="A	S	F	0	a1	a2	a3	R
A	S	F	0	a1	a2	a3	R
B	S	F	0	b1	b2	b3	R
B	S	F	0	b1	b2	b3	R
C	S	F	0	c1	c2	c3	R
D	S	F	0	d1	d2	d3	R"
	echo "$input" > input.test

	expected="A	2	a3
B	2	b3
C	1	c3
D	1	d3"
	echo "$expected" > expected.test
}

tearDown(){
	#PATH=$originalPath

	rm input.test
	rm expected.test
	rm result.test
}

testsortM4fromFile(){
	contigOverlapFrequencyLength.sh input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromRedirection(){
	contigOverlapFrequencyLength.sh < input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromPipe(){
	cat input.test | contigOverlapFrequencyLength.sh > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

# load shunit2
. shunit2
