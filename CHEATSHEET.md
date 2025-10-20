# Cheatsheet

My favorite keyboard shortcuts and commands when using Vim. Custom ones are inspired
by Visual Studio Code and VSCodeVim.

## Vim

| Category   | Input                    | Description                                                                                                      |
| ---------- | ------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| Move       |                          |                                                                                                                  |
|            | \$                       | Move to end of current line                                                                                      |
|            | *                        | Search in current buffer for current word (`n` for next occurrence, `N` for previous occurrence)                 |
|            | 0                        | Move to start of current line                                                                                    |
|            | _                        | Move to first character on current line                                                                          |
|            | b                        | Move backward to start of word                                                                                   |
|            | e                        | Move forward to end of word                                                                                      |
|            | f\<character\>           | Move to first occurrence of \<character\> on current line (`;` for next occurrence)                              |
|            | G                        | Move to last line of document                                                                                    |
|            | gg                       | Move to first line of document                                                                                   |
|            | gt                       | Move to next tab                                                                                                 |
|            | za                       | Toggle fold                                                                                                      |
|            | {                        | Move to previous paragraph                                                                                       |
|            | }                        | Move to next paragraph                                                                                           |
|            | ALT+q                    | Quit without prompt \[CUSTOM\]                                                                                   |
|            | ALT+w                    | Close current pane \[CUSTOM\]                                                                                    |
|            | CTRL+d OR u              | Scroll, downward or upward                                                                                       |
|            | CTRL+h                   | Cycle panes horizontally \[CUSTOM\]                                                                              |
|            | CTRL+i OR o              | Move position, next or previous                                                                                  |
|            | ENTER                    | Clear highlight                                                                                                  |
| Edit       |                          |                                                                                                                  |
|            | .                        | Repeat last shortcut that edited text                                                                            |
|            | >>                       | Indent current line                                                                                              |
|            | a                        | Insert after cursor                                                                                              |
|            | cgn                      | Replace search occurrence (use `*` before `cgn` and `.` after `cgn`)                                             |
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
|            | u OR CTRL+r              | Undo, redo                                                                                                       |
|            | vep                      | Paste and replace current word                                                                                   |
|            | x                        | Delete current character                                                                                         |
|            | yiw                      | Copy current word                                                                                                |
|            | yy                       | Copy current line                                                                                                |
|            | ALT+j OR k               | Move current line, down or up \[CUSTOM\]                                                                         |
|            | ALT+s                    | Save current buffer \[CUSTOM\]                                                                                   |
|            | CTRL+c                   | Escape \[CUSTOM\]                                                                                                |
|            | CTRL+n OR p              | Navigate auto-complete, next or previous (`CTRL+y` to accept)                                                    |
|            | \<leader\>cc             | Close quickfix \[CUSTOM\]                                                                                        |
|            | \<leader\>cn             | Move to next quickfix location \[CUSTOM\]                                                                        |
|            | \<leader\>cp             | Move to previous quickfix location \[CUSTOM\]                                                                    |
|            | \<leader\>pd             | Disable Copilot \[CUSTOM\]                                                                                       |
|            | \<leader\>pe             | Enable Copilot \[CUSTOM\]                                                                                        |
|            | \<leader\>sa             | Save all buffers \[CUSTOM\]                                                                                      |
|            | \<leader\>sc             | Save current buffer without autocommands \[CUSTOM\]                                                              |
| Select     |                          |                                                                                                                  |
|            | V                        | Select lines                                                                                                     |
|            | v                        | Select characters                                                                                                |
|            | vi\<character\>          | Move to first occurrence of \<character\> on current line and select in between \<character\>                    |
| Command    |                          |                                                                                                                  |
|            | /\<string\>              | Search in current buffer for \<string\> (`n` for next occurrence, `N` for previous occurrence)                   |
|            | :\<number\>              | Move to line \<number\>                                                                                          |
|            | :Replace abc%123         | Replace `abc` with `123` in all lines \[CUSTOM\]                                                                 |
|            | :ReplaceQF abc%123       | Replace `abc` with `123` in all quickfix locations \[CUSTOM\]                                                    |
| CoC        |                          |                                                                                                                  |
|            | :\<emoji\>               | Insert emoji (in Markdown)                                                                                       |
|            | gd                       | Jump to definition of code                                                                                       |
|            | gh                       | Show tooltip for code \[CUSTOM\]                                                                                 |
|            | gr                       | Show references for code                                                                                         |
|            | ALT+.                    | Open Code Actions \[CUSTOM\]                                                                                     |
|            | ALT+m                    | Show problems \[CUSTOM\]                                                                                         |
|            | CTRL+d OR u              | Scroll popup window, downward or upward \[CUSTOM\]                                                               |
|            | F2                       | Rename symbol \[CUSTOM\]                                                                                         |
|            | \<leader\>gu             | Copy GitHub URL of current line \[CUSTOM\]                                                                       |
|            | \<leader\>yh             | Show yank history \[CUSTOM\]                                                                                     |
| Commentary |                          |                                                                                                                  |
|            | gc                       | Toggle line comments for selected lines                                                                          |
|            | gcc                      | Toggle line comment for current line                                                                             |
| Copilot    |                          |                                                                                                                  |
|            | TAB                      | Accept suggestion                                                                                                |
| EasyMotion |                          |                                                                                                                  |
|            | SPACE                    | Toggle EasyMotion \[CUSTOM\]                                                                                     |
| Fugitive   |                          |                                                                                                                  |
|            | \<leader\>gb             | Show author of current line \[CUSTOM\]                                                                           |
|            | \<leader\>gd             | Show diff of current file \[CUSTOM\]                                                                             |
|            | \<leader\>gm             | Open merge conflicts in quickfix \[CUSTOM\]                                                                      |
| FZF        |                          |                                                                                                                  |
|            | ALT+f                    | Search in workspace \[CUSTOM\]                                                                                   |
|            | ALT+p                    | Search for file \[CUSTOM\]                                                                                       |
|            | CTRL+n OR p              | Navigate search results, next or previous (`ENTER` to open file, `CTRL+v` to open file in vertically split pane) |
|            | SHIFT+TAB                | Select search result (`ENTER` to open in quickfix)                                                               |
|            | \<leader\>fc             | Search for commit \[CUSTOM\]                                                                                     |
|            | \<leader\>fs             | Search for snippet for current filetype \[CUSTOM\]                                                               |
| Goyo       |                          |                                                                                                                  |
|            | ALT+z                    | Toggle Zen Mode \[CUSTOM\]                                                                                       |
| NERDTree   |                          |                                                                                                                  |
|            | m                        | Open menu                                                                                                        |
|            | R                        | Refresh tree                                                                                                     |
|            | s                        | Open file in vertically split pane                                                                               |
|            | ALT+r                    | Reveal file in tree \[CUSTOM\]                                                                                   |
|            | ALT+t                    | Toggle tree \[CUSTOM\]                                                                                           |
|            | ENTER                    | Open file                                                                                                        |
| Splitjoin  |                          |                                                                                                                  |
|            | gJ                       | Join current block into line                                                                                     |
|            | gS                       | Split current line into block                                                                                    |
| Surround   |                          |                                                                                                                  |
|            | cs{(                     | Replace `{}` with `()` in between cursor                                                                         |
|            | ds\<character\>          | Delete \<character\> in between cursor                                                                           |
|            | ysiw\<character\>        | Surround current word with \<character\>                                                                         |
| UltiSnips  |                          |                                                                                                                  |
|            | CTRL+j OR k              | Navigate placeholders, next or previous                                                                          |
| Undotree   |                          |                                                                                                                  |
|            | F1                       | Toggle tree \[CUSTOM\]                                                                                           |
| Vimspector |                          |                                                                                                                  |
|            | F5                       | Start debugging                                                                                                  |
|            | F9                       | Toggle breakpoint                                                                                                |
|            | \<leader\>di             | Inspect symbol under cursor                                                                                      |

## tmux

Shortcuts and commands are prefixed with `CTRL+b`.

| Category  | Input              | Description                                                |
| --------- | ------------------ | ---------------------------------------------------------- |
| Move      |                    |                                                            |
|           | CTRL+a             | Cycle panes vertically \[CUSTOM\]                          |
|           | CTRL+l             | Cycle panes horizontally \[CUSTOM\]                        |
|           | CTRL+z             | Zoom current pane \[CUSTOM\]                               |
| Shortcut  |                    |                                                            |
|           | "                  | Split pane horizontally                                    |
|           | %                  | Split pane vertically                                      |
|           | ,                  | Rename current window                                      |
|           | 1..9               | Focus window at position 1..9                              |
|           | <                  | Resize current pane leftwards by 10 columns \[CUSTOM\]     |
|           | >                  | Resize current pane rightwards by 10 columns \[CUSTOM\]    |
|           | [                  | Activate scroll (`DOWN` or `UP` to scroll, `q` to exit)    |
|           | c                  | Create new window                                          |
| Command   |                    |                                                            |
|           | :swap-window -t 0  | Swap current window with window at position 0              |

## GNU Readline

| Input  | Description                |
| ------ | -------------------------- |
| CTRL+a | Move to start of line      |
| CTRL+e | Move to end of line        |
| CTRL+r | Search backward in history |

## VSCode

### Extensions

* christian-kohler.npm-intellisense
* christian-kohler.path-intellisense
* davidanson.vscode-markdownlint
* dbaeumer.vscode-eslint
* esbenp.prettier-vscode
* formulahendry.code-runner
* github.vscode-github-actions
* golang.go
* kisstkondoros.vscode-gutter-preview
* orta.vscode-jest
* streetsidesoftware.code-spell-checker
* stylelint.vscode-stylelint
* TomRijndorp.find-it-faster
* usernamehw.errorlens
* vscodevim.vim

## MCP servers

* upstash/context

### Shortcuts

| Input                | Description                                              |
| -------------------- | -------------------------------------------------------- |
| ALT+CLICK            | Add another cursor at click position                     |
| ALT+DOWN or UP       | Move current line, down or up                            |
| ALT+ESC              | Show auto-complete                                       |
| ALT+SHIFT+DOWN or UP | Duplicate current line, down or up                       |
| CMD+1..3             | Focus `x` pane                                           |
| CMD+\                | Split pane vertically                                    |
| CMD+b                | Toggle side bar                                          |
| CMD+d                | Add another cursor at same word                          |
| CMD+f                | Search in current file                                   |
| CMD+k THEN w         | Close all tabs                                           |
| CMD+k THEN z         | Toggle Zen mode                                          |
| CMD+p                | Search for file (or `>` for actions and `@` for symbols) |
| CMD+q                | Quit                                                     |
| CMD+s                | Save current file                                        |
| CMD+w                | Close current pane                                       |
| CMD+ALT+DOWN or UP   | Add another cursor, down or up                           |
| CMD+ENTER            | Open file in vertically split pane                       |
| CMD+SHIFT+e          | Focus file explorer                                      |
| CMD+SHIFT+f          | Search in workspace                                      |
| CMD+SHIFT+j          | Search for file [FIND-IT-FASTER]                         |
| CMD+SHIFT+m          | Toggle problems                                          |
| CMD+SHIFT+u          | Search in workspace [FIND-IT-FASTER]                     |
| CMD+SHIFT+v          | Open Preview                                             |
| CTRL+\`              | Toggle/focus Terminal                                    |
| CTRL+CMD+i           | Toggle Chat                                              |
| CTRL+SHIFT+r         | Open Refactorings/Code Actions                           |
| CTRL+TAB             | Navigate tabs                                            |
| F2                   | Rename symbol                                            |
| SHIFT+ESC            | Hide auto-complete                                       |
