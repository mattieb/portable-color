# Changes

## Unreleased

The new portable-color will focus on better alignment with other tools, better code, and easier embeddability.

1.  Environment variable processing is now fully aligned with the [Standard for ANSI Colors in Terminals](http://bixense.com/clicolors/). Change-wise, this means "NO_COLOR" takes priority over everything, and neither "NO_COLOR" and "CLICOLOR_FORCE" have special behavior if set to "0". This matches the behavior of other tools.

2.  Authors may choose to use a new "default-off" color mode, where their scripts will not use color unless "CLICOLOR" or "CLICOLOR_FORCE" is explicitly set, even if they would otherwise.

## 1.0.0 - 2023-06-17

Initial release.
