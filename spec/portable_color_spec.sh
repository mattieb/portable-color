# shellcheck shell=sh disable=SC2034,SC2317

Describe "portable-color.sh"
    Include portable-color.sh

    Describe "color_on"
        Parameters
        #   tty N_C C_F CC  default-off color_on
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

        Example "$6 for $1, NO_COLOR=\"$2\", CLICOLOR_FORCE=\"$3\", CLICOLOR=\"$4\", color_on $5"
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

            When run color_on "$5"
            The status should be "$6"
        End 
    End

    Describe "color_setup"
        It "uses \"true\" if tput cannot be found"
            which() {
                echo "$1 not found"
                return 1
            }

            When call color_setup
            The variable TPUT should equal "true"

        End

        It "uses \"true\" if color_on returns failure"
            color_on() {
                return 1
            }

            When call color_setup
            The variable TPUT should equal "true"
        End

        It "uses found tput binary if color_on returns success"
            which() {
                echo /path/to/tput
            }

            color_on() {
                return 0
            }

            When call color_setup
            The variable TPUT should equal "/path/to/tput"
        End

        It "passes parameters to color_on"
            which() {
                echo /path/to/tput
            }

            color_on() {
                [ "$1" = "passed-param" ]
            }

            When call color_setup passed-param
            The variable TPUT should equal "/path/to/tput"
        End
    End

End
