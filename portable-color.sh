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

# This complicated incantation respects several combinations of NO_COLOR, CLICOLOR, CLICOLOR_FORCE,
# and whether or not we're outputting to a tty and if "tput" can actually be found. If we don't
# want to try color, we use "true" instead, which will always return success.

color_on() {
	[ -n "${NO_COLOR}" ] && return 1
	[ -n "${CLICOLOR_FORCE}" ] && return 0
	if test -t 1; then
		[ -n "${CLICOLOR}" ] && return 0
		[ "$1" = "default-off" ] && return 1
		return 0
	fi
	return 1
}

TPUT=$(which tput)
test -x "${TPUT}" && color_on || TPUT=true

# Invoke tput, but throw away any error messages or codes.

tput() {
	"${TPUT}" $@ 2>/dev/null || true
}

# Wrap text between a supplied tput capability and arguments and sgr0, which will turn off all
# terminal attributes.

tput_wrap() {
	capability=$1
	shift
	echo $(tput ${capability})$@$(tput sgr0)
}

# These capabilities require no arguments, so they're easy to use with "tput_wrap".

bold() {
	echo $(tput_wrap bold $@)
}

# ANSI color capabilities require an argument. Shift that argument off and pass everything to
# "tput_wrap" as its first argument.

setaf() {
	arg=$1
	shift
	echo $(tput_wrap "setaf ${arg}" $@)
}

# Now we can implement colors as calls to "setaf".

black() {
	setaf 0 $@
}
red() {
	setaf 1 $@
}
green() {
	setaf 2 $@
}
yellow() {
	setaf 3 $@
}
blue() {
	setaf 4 $@
}
magenta() {
	setaf 5 $@
}
cyan() {
	setaf 6 $@
}
white() {
	setaf 7 $@
}
