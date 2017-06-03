#!/bin/bash
## https://github.com/kward/shunit2
## http://manpages.ubuntu.com/manpages/trusty/man1/shunit2.1.html
## http://www.mikewright.me/shunit2-bash-testing.html
## https://code.tutsplus.com/tutorials/test-driving-shell-scripts--net-31487

setUp(){
	#originalPath=$PATH
	#PATH=$PWD:$PATH
	input="D	C	S	F	0	1	2	2	R	0	1	2
A	B	S	F	0	1	2	3	R	0	1	1
B	A	S	F	0	0	1	2	R	1	2	2"
	echo "$input" > input.test

	expected="D	C	S	F	0	1	2	2	R	0	1	2
B	A	S	F	0	0	1	2	R	1	2	2"
	echo "$expected" > expected.test
}

tearDown(){
	#PATH=$originalPath

	rm input.test
	rm expected.test
	rm result.test
}

testsortM4fromFile(){
	removeSubOverlapsM4.sh input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromRedirection(){
	removeSubOverlapsM4.sh < input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromPipe(){
	cat input.test | removeSubOverlapsM4.sh > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

# load shunit2
. shunit2
