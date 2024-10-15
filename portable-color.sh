# shellcheck shell=sh
#
# Copyright (c) 2023 Mattie Behrens.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# color_on determines whether or not to try color. It is used by color_setup.

color_on() {
	[ -n "${NO_COLOR}" ] && return 1
	[ -n "${CLICOLOR_FORCE}" ] && return 0
	test -t 1 || return 1
	[ -n "${CLICOLOR}" ] && return 0
	[ "$1" = "default-off" ] && return 1
	return 0
}

# Call color_setup (optionally, with the "default-off" argument to indicate you
# do not want to turn color on by default unless the user requests it via
# environment variable) to set up the system. The environment variable TPUT
# will be set to either the TPUT binary or true as a no-op.

color_setup() {
	TPUT=$(which tput 2>/dev/null) && color_on "$@" || TPUT=true
}

# To avoid printing errors in case unknown capabilities are tried, wrap tput
# and discard errors.

tput() {
	"${TPUT}" "$@" 2>/dev/null || true
}

# Write a capability and then write sgr0 to reset all. Most capabilities must
# be reset this way.

tput_wrap() {
	output="$1"
	shift
	tput "$@"
	printf %s "$output"
	tput sgr0
}

# These capabilities requires sgr0 undo.

bold() { tput_wrap "$1" bold; }
black() { tput_wrap "$1" setaf 0; }
red() { tput_wrap "$1" setaf 1; }
green() { tput_wrap "$1" setaf 2; }
yellow() { tput_wrap "$1" setaf 3; }
blue() { tput_wrap "$1" setaf 4; }
magenta() { tput_wrap "$1" setaf 5; }
cyan() { tput_wrap "$1" setaf 6; }
white() { tput_wrap "$1" setaf 7; }

# Standout has its own undo.

standout() { tput smso; printf %s "$1"; tput rmso; }
