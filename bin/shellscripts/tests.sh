#!/bin/bash
## file: tests.sh

## https://github.com/kward/shunit2
## http://manpages.ubuntu.com/manpages/trusty/man1/shunit2.1.html
## http://www.mikewright.me/shunit2-bash-testing.html

input="D	C	S	F	0	d1	d2	d3	R	c1	c2	c2
A	B	S	F	0	a1	a2	a3	R	b1	b2	b3
B	A	S	F	0	b1	b2	b3	R	a1	a2	a3"

sortM4.sh <("{$input}")

exit

testsortM4()
{
	input="D	C	S	F	0	d1	d2	d3	R	c1	c2	c2
A	B	S	F	0	a1	a2	a3	R	b1	b2	b3
B	A	S	F	0	b1	b2	b3	R	a1	a2	a3"
	result=./sortM4.sh input
	expected="D	C	S	F	0	d1	d2	d3	R	c1	c2	c2
A	B	S	F	0	a1	a2	a3	R	b1	b2	b3
B	A	S	F	0	b1	b2	b3	R	a1	a2	a3"

	assertEquals "${result}" "${output}"
}

# load shunit2
. shunit2
