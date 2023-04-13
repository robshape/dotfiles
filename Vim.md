# Vim

Keyboard shortcuts and commands for Vim, tmux, and GNU Readline.

## Vim

Inputs that are specific for Vim.

| Category   | Input                    | Description                                                                                                      |
| ---------- | ------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| Move       |                          |                                                                                                                  |
|            | \$                       | Move to end of current line                                                                                      |
|            | *                        | Search in current buffer for current word                                                                        |
|            | 0                        | Move to start of current line                                                                                    |
|            | b                        | Move backward to start of word                                                                                   |
|            | e                        | Move forward to end of word                                                                                      |
|            | f\<character\>           | Move to first occurrence of \<character\> on current line (`;` for next occurrence, `,` for previous occurrence) |
|            | G                        | Move to last line of document                                                                                    |
|            | gg                       | Move to first line of document                                                                                   |
|            | gi                       | Move to last insert                                                                                              |
|            | gt                       | Move to next tab                                                                                                 |
|            | {                        | Move to previous paragraph                                                                                       |
|            | }                        | Move to next paragraph                                                                                           |
|            | ALT+c                    | Delete all buffers, except current buffer, and clear yank history \[CUSTOM SHORTCUT\]                            |
|            | ALT+q                    | Quit without prompt \[CUSTOM SHORTCUT\]                                                                          |
|            | ALT+w                    | Close current pane \[CUSTOM SHORTCUT\]                                                                           |
|            | CTRL+d OR u              | Scroll half a page, downward or upward                                                                           |
|            | CTRL+h                   | Navigate panes \[CUSTOM SHORTCUT\]                                                                               |
|            | CTRL+i OR o              | Move position, next or previous                                                                                  |
|            | ENTER                    | Clear highlighted search results                                                                                 |
|            | TAB                      | Navigate buffers \[CUSTOM SHORTCUT\]                                                                             |
| Edit       |                          |                                                                                                                  |
|            | .                        | Repeat last shortcut that edited text                                                                            |
|            | =G                       | Format indentation downward to last line of document                                                             |
|            | a                        | Insert after cursor                                                                                              |
|            | ce                       | Replace until end of current word                                                                                |
|            | cgn                      | Replace next search occurrence (use with `*` and `.`)                                                            |
|            | ci\<character\>          | Replace in between \<character\>                                                                                 |
|            | ciw                      | Replace current word                                                                                             |
|            | D                        | Cut to end of current line                                                                                       |
|            | daB                      | Cut `{}` block                                                                                                   |
|            | dab                      | Cut `()` block                                                                                                   |
|            | dd                       | Cut current line                                                                                                 |
|            | dt\<character\>          | Cut to first occurrence of \<character\> on current line                                                         |
|            | i                        | Insert before cursor                                                                                             |
|            | O                        | Append new line above current line                                                                               |
|            | o                        | Append new line below current line                                                                               |
|            | p                        | Paste                                                                                                            |
|            | r\<character\>           | Replace current character with \<character\>                                                                     |
|            | S                        | Delete current line and insert                                                                                   |
|            | u OR CTRL+r              | Undo, redo                                                                                                       |
|            | vep                      | Paste and replace current word                                                                                   |
|            | x                        | Delete current character                                                                                         |
|            | yiw                      | Copy current word                                                                                                |
|            | yy                       | Copy current line                                                                                                |
|            | ALT+j OR k               | Move current line, down or up \[CUSTOM SHORTCUT\]                                                                |
|            | ALT+s                    | Save current buffer \[CUSTOM SHORTCUT\]                                                                          |
|            | CTRL+c                   | Escape                                                                                                           |
|            | CTRL+n OR p              | Navigate auto-complete, next or previous (`CTRL+y` to accept)                                                    |
| Select     |                          |                                                                                                                  |
|            | V                        | Start VISUAL MODE per line                                                                                       |
|            | v                        | Start VISUAL MODE per character                                                                                  |
| Command    |                          |                                                                                                                  |
|            | /\<string\>              | Search in current buffer for \<string\> (`n` for next occurrence)                                                |
|            | :%!\<cli\>               | Pipe current buffer to \<cli\>                                                                                   |
|            | :%s/abc/123/gc           | Replace `abc` with `123` in all lines after confirmation                                                         |
|            | :&&                      | Repeat replace                                                                                                   |
|            | :bd                      | Delete current buffer                                                                                            |
|            | :ccl                     | Close quickfix                                                                                                   |
|            | :cfdo %s/abc/123/g \| up | Replace `abc` with `123` in all quickfix files                                                                   |
|            | :cn                      | Move to next quickfix position                                                                                   |
|            | :Replace abc/123         | Replace `abc` with `123` in all lines \[CUSTOM COMMAND\]                                                         |
|            | :ReplaceCF abc/123       | Replace `abc` with `123` in all quickfix files \[CUSTOM COMMAND\]                                                |
| CoC        |                          |                                                                                                                  |
|            | :\<emoji\>               | Insert emoji (in Markdown file) \[INSERT MODE\]                                                                  |
|            | gd                       | Jump to definition of code                                                                                       |
|            | gh                       | Show tooltip for code \[CUSTOM SHORTCUT\]                                                                        |
|            | gr                       | Show references for code                                                                                         |
|            | yh                       | Show yank history \[CUSTOM SHORTCUT\]                                                                            |
|            | ALT+m                    | Show problems \[CUSTOM SHORTCUT\]                                                                                |
|            | ALT+r                    | Open Refactorings/Code Actions \[CUSTOM SHORTCUT\]                                                               |
|            | CTRL+d OR u              | Scroll floating window, downward or upward \[CUSTOM SHORTCUT\]                                                   |
|            | F2                       | Rename symbol \[CUSTOM SHORTCUT\]                                                                                |
|            | :GitHubCopyURL           | Copy GitHub URL of current line \[CUSTOM COMMAND\]                                                               |
| Commentary |                          |                                                                                                                  |
|            | gcc                      | Toggle line comment for current line                                                                             |
| Copilot    |                          |                                                                                                                  |
|            | TAB                      | Accept suggestion \[INSERT MODE\]                                                                                |
| EasyMotion |                          |                                                                                                                  |
|            | SPACE                    | Toggle EasyMotion \[CUSTOM SHORTCUT\]                                                                            |
| Fugitive   |                          |                                                                                                                  |
|            | :G blame                 | Show author of current line                                                                                      |
|            | :G mergetool             | Open merge conflicts in quickfix                                                                                 |
|            | :Gdiffsplit              | Show diff of current file                                                                                        |
| FZF        |                          |                                                                                                                  |
|            | ALT+f                    | Search in workspace \[CUSTOM SHORTCUT\]                                                                          |
|            | ALT+p                    | Search for file \[CUSTOM SHORTCUT\]                                                                              |
|            | CTRL+n OR p              | Navigate search results, next or previous (`ENTER` to open file, `CTRL+v` to open file in vertically split pane) |
|            | SHIFT+TAB                | Select search result (`ENTER` to open in quickfix)                                                               |
|            | :Commits                 | Search for commit                                                                                                |
|            | :Snippets                | Search for snippet for current filetype                                                                          |
| NERDTree   |                          |                                                                                                                  |
|            | m                        | Open menu                                                                                                        |
|            | R                        | Refresh tree                                                                                                     |
|            | s                        | Open file in vertically split pane                                                                               |
|            | ALT+d                    | Reveal file in tree \[CUSTOM SHORTCUT\]                                                                          |
|            | ALT+t                    | Toggle tree \[CUSTOM SHORTCUT\]                                                                                  |
|            | ENTER                    | Open file                                                                                                        |
| Splitjoin  |                          |                                                                                                                  |
|            | gJ                       | Join current block into line                                                                                     |
|            | gS                       | Split current line into block                                                                                    |
| Surround   |                          |                                                                                                                  |
|            | cs})                     | Replace `}` with `)` in between cursor                                                                           |
|            | ysiw\<character\>        | Surround current word with \<character\>                                                                         |
| UltiSnips  |                          |                                                                                                                  |
|            | CTRL+j OR k              | Navigate placeholders, next or previous                                                                          |
| Undotree   |                          |                                                                                                                  |
|            | F5                       | Toggle tree                                                                                                      |

## tmux

Inputs that are specific for tmux. Shortcuts and commands are prefixed with `CTRL+b`.

| Category  | Input              | Description                                                          |
| --------- | ------------------ | -------------------------------------------------------------------- |
| Move      |                    |                                                                      |
|           | CTRL+l             | Navigate panes horizontally \[CUSTOM SHORTCUT\]                      |
| Shortcut  |                    |                                                                      |
|           | "                  | Split pane horizontally                                              |
|           | %                  | Split pane vertically                                                |
|           | ,                  | Rename current window                                                |
|           | 0..9               | Focus window at position 0..9                                        |
|           | >                  | Resize current pane towards right by 100 columns \[CUSTOM SHORTCUT\] |
|           | [                  | Activate scroll (`DOWN` or `UP` to scroll, `q` to exit)              |
|           | c                  | Create new window                                                    |
|           | z                  | Zoom current pane                                                    |
| Command   |                    |                                                                      |
|           | :swap-window -t 0  | Swap current window with window at position 0                        |

## GNU Readline

Inputs that are specific for GNU Readline.

| Input  | Description                |
| ------ | -------------------------- |
| CTRL+a | Move to start of line      |
| CTRL+e | Move to end of line        |
| CTRL+r | Search backward in history |
