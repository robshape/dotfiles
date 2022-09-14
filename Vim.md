# Vim (with tmux)

Keyboard shortcuts and commands for Vim inside tmux.

## Vim

Inputs that are specific for Vim.

| Category   | Input                  | Description                                                                                                |
| ---------- | ---------------------- | ---------------------------------------------------------------------------------------------------------- |
| Move       |                        |                                                                                                            |
|            | \$                     | Move to end of current line                                                                                |
|            | %                      | Move to matching character (`()`, `[]`, `{}`)                                                              |
|            | \*                     | Move to next occurrence of current word                                                                    |
|            | 0                      | Move to start of current line                                                                              |
|            | b                      | Move backward to start of word                                                                             |
|            | e                      | Move forward to end of word                                                                                |
|            | f\<character\>         | Move to first occurrence of \<character\> on current line (`;` for next occurrence)                        |
|            | G                      | Move to last line of document                                                                              |
|            | gg                     | Move to first line of document                                                                             |
|            | H                      | Move to top of page                                                                                        |
|            | L                      | Move to bottom of page                                                                                     |
|            | M                      | Move to center of page                                                                                     |
|            | ZZ                     | Save and quit current buffer                                                                               |
|            | [{                     | Move to start of block                                                                                     |
|            | ]}                     | Move to end of block                                                                                       |
|            | {                      | Move to previous paragraph                                                                                 |
|            | }                      | Move to next paragraph                                                                                     |
|            | ALT+c                  | Delete all buffers except current buffer and restart CoC \[NORMAL MODE\] \[CUSTOM SHORTCUT\]               |
|            | ALT+q                  | Quit without prompt \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | ALT+w                  | Close current pane \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                     |
|            | CTRL+b OR f            | Move one page, backward or forward                                                                         |
|            | CTRL+d OR u            | Scroll, downward or upward                                                                                 |
|            | CTRL+h                 | Navigate panes \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                         |
|            | CTRL+i OR o            | Move position, next or previous                                                                            |
|            | ENTER                  | Clear highlighted search results                                                                           |
|            | SHIFT+TAB              | Navigate buffers backward \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                              |
|            | TAB                    | Navigate buffers forward \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                               |
| Edit       |                        |                                                                                                            |
|            | .                      | Repeat last shortcut that edited text                                                                      |
|            | =G                     | Format indentation downward to last line of document                                                       |
|            | a                      | Insert after cursor                                                                                        |
|            | ce                     | Replace until end of current word                                                                          |
|            | ci\<character\>        | Replace in between \<character\>                                                                           |
|            | ciw                    | Replace current word                                                                                       |
|            | D                      | Cut to end of current line                                                                                 |
|            | daB                    | Cut `{}` block                                                                                             |
|            | dab                    | Cut `()` block                                                                                             |
|            | dd                     | Cut current line                                                                                           |
|            | dt\<character\>        | Cut to first occurrence of \<character\> on current line                                                   |
|            | g&                     | Repeat replace in all lines                                                                                |
|            | i                      | Insert before cursor                                                                                       |
|            | O                      | Append new line above current line                                                                         |
|            | o                      | Append new line below current line                                                                         |
|            | p                      | Paste                                                                                                      |
|            | r\<character\>         | Replace character under cursor with \<character\>                                                          |
|            | S                      | Delete current line and insert                                                                             |
|            | s                      | Delete character under cursor and insert                                                                   |
|            | u                      | Undo                                                                                                       |
|            | vep                    | Paste and replace current word                                                                             |
|            | x                      | Delete character under cursor                                                                              |
|            | yiw                    | Copy current word                                                                                          |
|            | yy                     | Copy current line                                                                                          |
|            | ALT+j OR k             | Move current line, down or up \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                          |
|            | ALT+s                  | Save current buffer \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | CTRL+[                 | Escape                                                                                                     |
|            | CTRL+d OR t            | Indent current line, left or right \[INSERT MODE\]                                                         |
|            | CTRL+n OR p            | Navigate auto-complete, next or previous (`CTRL+y` to confirm)                                             |
|            | CTRL+r                 | Redo                                                                                                       |
|            | SHIFT+, OR .           | Indent current line, left or right \[VISUAL MODE\]                                                         |
| Select     |                        |                                                                                                            |
|            | V                      | Start VISUAL MODE per line                                                                                 |
|            | v                      | Start VISUAL MODE per character                                                                            |
| Command    |                        |                                                                                                            |
|            | /\<string\>            | Search in current buffer for \<string\> (`n` for next occurrence)                                          |
|            | :%s/abc/123/gc         | Replace `abc` with `123` in all lines after confirmation                                                   |
|            | :bd \[\<path\>\]       | Delete current buffer or buffer at \<path\>                                                                |
|            | :tabn                  | Move to next tab                                                                                           |
| CoC        |                        |                                                                                                            |
|            | gd                     | Jump to definition of code                                                                                 |
|            | gh                     | Show tooltip for code \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                  |
|            | gr                     | Show references for code                                                                                   |
|            | yh                     | Show yank history \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                      |
|            | ALT+m                  | Show problems \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                          |
|            | ALT+r                  | Open Refactorings/Code Actions\[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                          |
|            | CTRL+SPACE             | Toggle auto-complete                                                                                       |
|            | F2                     | Rename symbol \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                          |
|            | :CocCommand yank.clean | Clear yank history                                                                                         |
|            | :CocRestart            | Restart extensions                                                                                         |
|            | :CocUpdate             | Update extensions                                                                                          |
| Commentary |                        |                                                                                                            |
|            | gc2j                   | Toggle line comment downward 2 lines                                                                       |
|            | gcc                    | Toggle line comment for current line                                                                       |
| EasyMotion |                        |                                                                                                            |
|            | SPACE                  | Toggle EasyMotion \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                      |
| FZF        |                        |                                                                                                            |
|            | ALT+f                  | Search in workspace \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | ALT+p                  | Search for file \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                        |
|            | CTRL+j OR k            | Navigate search results, down or up (`ENTER` to open file, `CTRL+v` to open file in vertically split pane) |
|            | :Snippets              | Show available snippets for current filetype                                                               |
| NERDTree   |                        |                                                                                                            |
|            | m                      | Open menu                                                                                                  |
|            | R                      | Refresh tree                                                                                               |
|            | s                      | Open file in vertically split pane                                                                         |
|            | ALT+d                  | Reveal file in tree \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | ALT+t                  | Toggle tree \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                            |
|            | ENTER                  | Open file                                                                                                  |
| Splitjoin  |                        |                                                                                                            |
|            | gJ                     | Join current block into line                                                                               |
|            | gS                     | Split current line into block                                                                              |
| Surround   |                        |                                                                                                            |
|            | cs})                   | Replace `}` with `)` in between cursor                                                                     |
|            | ysiw"                  | Surround current word with `"`                                                                             |
| UltiSnips  |                        |                                                                                                            |
|            | CTRL+j OR k            | Navigate placeholders, next or previous                                                                    |
|            | :UltiSnipsEdit         | Open snippets file for current filetype                                                                    |
| vim-plug   |                        |                                                                                                            |
|            | :PlugUpdate            | Update plugins                                                                                             |
|            | :PlugUpgrade           | Upgrade vim-plug                                                                                           |

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
|           | {                  | Move current pane to left                                            |
| Command   |                    |                                                                      |
|           | :swap-window -t 0  | Swap current window with window at position 0                        |
