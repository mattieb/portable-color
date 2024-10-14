# shellcheck shell=sh

Describe "portable-color.sh"
    Include portable-color.sh
    It "Forces color on with CLICOLOR_FORCE"
        CLICOLOR_FORCE=1
        When call color_on
        The status should be success
    End
End
