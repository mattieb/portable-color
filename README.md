# portable-color

portable-color is designed to be included or sourced in your shell scripts, providing you the capability to use color and other emphasis to make your output easier for humans to parse.

portable-color is _portable_ because it has been carefully written to work everywhere possible, sticking closely to POSIX, working with standard facilities for terminal capabilities, and gracefully backing down when those aren't available.

portable-color is also _respectful_, sticking to the [Standard for ANSI Colors in Terminals](http://bixense.com/clicolors/) (e.g. "NO_COLOR", "CLICOLOR", and friends) and also offering script authors the ability to easily create scripts that don't even use color unless specifically asked-for.

This is a new version of portable-color. I wrote about the original in ["How and Why You Should Add Color to Your Scripts"](https://spin.atomicobject.com/2023/05/25/color-scripts/) at [Atomic Spin](https://spin.atomicobject.com/), and have since changed my mind on a few things. See [the change log](./CHANGELOG.md) for the quick story, and [my notes](./NOTES.md) for more details.

## Installation

You can use portable-color a few ways.

### Embedded

The easiest way to use portable-color is to embed the parts you're going to use into your script. 

That includes, at a minimum, the following functions:

- _try_color
- setup_color
- _qtput

All of the color functions and "bold" also require "_twrap".

Finally, you can add just the color and emphasis functions you need.

### As a library

You can install or link "portable-color.sh" into `${HOME}/.local/bin` and add this directory to your PATH if it is not already there.

Don't make it executable. The [POSIX standard dot](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#dot) will search PATH and does not require files it finds to be executable, so leaving it non-executable means it won't be executed interactively by accident, or show up in autocomplete.

I wrote more about my thoughts about how a shell library setup works in ["A proposal for shell libraries"](https://mattiebee.io/44251/a-proposal-for-shell-libraries).

## Usage

Before you can do anything with portable-color, your script must get set up. You can do this two ways.

"setup_color" with no arguments will default to using color (unless the user expresses a preference for none.)

```shell
setup_color
```

"setup_color" with a "default-off" argument will default to _not_ using color unless the user expresses a preference for color, e.g. by setting "CLICOLOR".

```shell
setup_color default-off
```

Once "setup_color" has run, the variable "TPUT" will contain either the path to the system's [tput](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/tput.html) program, or "true" which works as a no-op. (You generally don't need to know this, but you can leverage this fact if you want to stop here and use capabilities directly.)

Several emphasis functions can be used as wrappers. Each one takes a _single_ argument (note how this is different from "echo"); the easiest way to work with this is by using double quotes, which allow you to nest more emphasis functions and variable subsitutions and the like within.

```shell
echo $(green "Hello, ${USER}.")
```

It's important to note that many emphasis functions, like colors and bold, will do a full reset when they close out, because that's the way their terminal capabilities work.

This means that, in the example below, at the conclusion of "blue", "bold" is actually reset—so we can't just add more text after the call to "blue" here. It's best to just make another "bold" call.

```shell
echo $(bold "Welcome to $(blue "portable-color")")$(bold ".")
```
