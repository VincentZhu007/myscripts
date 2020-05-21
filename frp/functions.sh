#!/bin/bash
#
# Useful function collections.

# Set variables
declare -r TRUE=0
declare -r FALSE=1

# Test if current user is root.
function is_root() {
	[ $(id -u) -eq 0 ] && return $TRUE || return $FALSE
}

# Test machine bits
function get_os_bits () {
	[ $(getconf WORD_BIT) -eq '32' ] && [ $(getconf LONG_BIT) -eq '64' ] && echo '64' || echo '32'
}

function test_functions() {
	is_root && echo "You are a root user." || echo "You are not a root user."
	echo "Current OS bits:" $(get_os_bits)
}

# test_functions
