# Notes

## Detecting color

[Standard for ANSI Colors in Terminals](http://bixense.com/clicolors/) proposes:

> *   "NO_COLOR" set
>     *   Don’t output ANSI color escape codes, see [no-color.org](https://no-color.org)
> *   "CLICOLOR_FORCE" set, but "NO_COLOR" unset
>     *   ANSI colors should be enabled no matter what
> *   "CLICOLOR" set, "NO_COLOR" and "CLICOLOR_FORCE" unset
>     *   ANSI colors are supported and should be used when the program is writing to a terminal
> *   none of the above environment variables are set
>     *   ANSI colors are not explicitly requested
>     *   Older programs newly gaining colors may prefer to disable them by default
>     *   New programs may prefer to operate as if "CLICOLOR" is set

And [NO_COLOR](https://no-color.org) proposes (emphasis mine):

> Command-line software which adds ANSI color to its output by default should check for a NO_COLOR environment variable that, when present and not an empty string (regardless of its value), prevents the addition of ANSI color.

but then also provides this example source code:

> ```c
> if (no_color != NULL && no_color[0] != '\0')
>     color = false;
> ```

It seemed logical at the time to me to also run with this "0" or "1" thing, but on reflection (and observing the behavior of some tools, e.g. "brew"), I'm going to reverse course and just go by "is it set?" This also will simplify color configuration detection.

"NO_COLOR" should also take priority over "CLICOLOR_FORCE", which is again a change in behavior.
