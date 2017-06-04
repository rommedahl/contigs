#!/bin/bash
## https://github.com/kward/shunit2
## http://manpages.ubuntu.com/manpages/trusty/man1/shunit2.1.html
## http://www.mikewright.me/shunit2-bash-testing.html
## https://code.tutsplus.com/tutorials/test-driving-shell-scripts--net-31487

setUp(){
	#originalPath=$PATH
	#PATH=$PWD:$PATH
	input="A	4
B	3
C	2
D	1"
	echo "$input" > input.test

	expected="A
D"
	echo "$expected" > expected.test
}

tearDown(){
	#PATH=$originalPath

	rm input.test
	rm expected.test
	rm result.test
}

testsortM4fromFile(){
	contigsOutsideBound.sh -l 2 -u 3 input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromRedirection(){
	contigsOutsideBound.sh -l 2 -u 3 < input.test > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

testsortM4fromPipe(){
	cat input.test | contigsOutsideBound.sh -l 2 -u 3 > result.test
	diff expected.test result.test
	assertTrue 'Expected output differs.' $?
}

# load shunit2
. shunit2
