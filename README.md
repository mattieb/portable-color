# portable-color

This script fragment is designed to be included or sourced in your shell scripts, providing you the capability to output in bold and color to emphasize some of your output for humans.

I wrote more about it in ["How and Why You Should Add Color to Your Scripts"](https://spin.atomicobject.com/2023/05/25/color-scripts/) at [Atomic Spin](https://spin.atomicobject.com/).

See [the example script](./example) to see how to use it.

## Installation

I recommend you install or link "portable-color.sh" into `${HOME}/.local/bin` and add this directory to your PATH if it is not already there.

I also recommend you do _not_ make it executable. The [POSIX standard dot](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#dot) will search PATH and does not require files it finds to be executable. Marking this non-executable will it not be invoked interactively.

I wrote more about my thoughts in ["A proposal for shell libraries"](https://mattiebee.io/44251/a-proposal-for-shell-libraries) on [my blog](https://mattiebee.io/).
