# Changes

## 2.0.0 - 2024-10-15

This version focuses on better alignment with other tools, better code, and a better integration experience.

1.  Color functions now take a single quoted string argument instead of trying to act like "echo". For example:

    ```shell
    echo $(green "It's not easy being... you know.")
    ```

2.  Setup is no longer explicit. Call "setup_color" to configure.

3.  Environment variable semantics are now fully aligned with the [Standard for ANSI Colors in Terminals](http://bixense.com/clicolors/). Change-wise, this means "NO_COLOR" takes priority over everything, and neither "NO_COLOR" and "CLICOLOR_FORCE" have special behavior if set to "0". This matches the behavior of other tools.

4.  Authors may choose to use a new "default-off" color mode when calling "setup_color", where their scripts will not use color unless "CLICOLOR" or "CLICOLOR_FORCE" is explicitly set, even if they would otherwise.

## 1.0.0 - 2023-06-17

Initial release.
