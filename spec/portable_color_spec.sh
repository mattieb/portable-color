# shellcheck shell=sh disable=SC2034,SC2317
#
# Copyright (c) 2024 Mattie Behrens.
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

Describe "portable-color.sh"
    Include portable-color.sh

    Describe "_try_color"
        Parameters
        #   tty N_C C_F CC  default-off _try_color
            tty ""  ""  ""  ""          success
            tty ""  ""  ""  default-off failure
            tty set ""  ""  ""          failure
            tty set ""  ""  default-off failure
            tty ""  set ""  ""          success
            tty ""  set ""  default-off success
            tty set set ""  ""          failure
            tty set set ""  default-off failure
            tty ""  ""  set ""          success
            tty ""  ""  set default-off success
            tty set ""  set ""          failure
            tty set ""  set default-off failure
            tty ""  set set ""          success
            tty ""  set set default-off success
            tty set set set ""          failure
            tty set set set default-off failure
            not ""  ""  ""  ""          failure
            not ""  ""  ""  default-off failure
            not set ""  ""  ""          failure
            not set ""  ""  default-off failure
            not ""  set ""  ""          success
            not ""  set ""  default-off success
            not set set ""  ""          failure
            not set set ""  default-off failure
            not ""  ""  set ""          failure
            not ""  ""  set default-off failure
            not set ""  set ""          failure
            not set ""  set default-off failure
            not ""  set set ""          success
            not ""  set set default-off success
            not set set set ""          failure
            not set set set default-off failure
        End

        Example "$6 for $1, NO_COLOR=\"$2\", CLICOLOR_FORCE=\"$3\", CLICOLOR=\"$4\", _try_color $5"
            if [ "$1" = "tty" ]; then
                test()
                {
                    [ "$1" = "-t" ] && [ "$2" = "1" ] && return 0
                    [ "$@" ]
                }
            else
                test()
                {
                    [ "$1" = "-t" ] && [ "$2" = "1" ] && return 1
                    [ "$@" ]
                }
            fi

            NO_COLOR="$2"
            CLICOLOR_FORCE="$3"
            CLICOLOR="$4"

            When run _try_color "$5"
            The status should be "$6"
        End 
    End

    Describe "setup_color"
        It "uses \"true\" if tput cannot be found"
            which() {
                echo "$1 not found"
                return 1
            }

            When call setup_color
            The variable TPUT should equal "true"

        End

        It "uses \"true\" if _try_color returns failure"
            _try_color() {
                return 1
            }

            When call setup_color
            The variable TPUT should equal "true"
        End

        It "uses found tput binary if _try_color returns success"
            which() {
                echo /path/to/tput
            }

            _try_color() {
                return 0
            }

            When call setup_color
            The variable TPUT should equal "/path/to/tput"
        End

        It "passes parameters to _try_color"
            which() {
                echo /path/to/tput
            }

            _try_color() {
                [ "$1" = "passed-param" ]
            }

            When call setup_color passed-param
            The variable TPUT should equal "/path/to/tput"
        End
    End

End
