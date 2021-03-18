# Vim for tmux

Keyboard shortcuts and commands for Vim inside tmux.

## Vim

Inputs that are specific for Vim.

| Category   | Input            | Description                                                                                                |
| ---------- | ---------------- | ---------------------------------------------------------------------------------------------------------- |
| Move       |                  |                                                                                                            |
|            | \$               | Move to end of current line                                                                                |
|            | %                | Move to matching character (`()`, `[]`, `{}`)                                                              |
|            | \*               | Move to next occurrence of word under cursor                                                               |
|            | 0                | Move to start of current line                                                                              |
|            | b                | Move backwards to start of word                                                                            |
|            | e                | Move forwards to end of word                                                                               |
|            | f'               | Move to first occurrence of `'` on current line (`;` for next occurrence)                                  |
|            | G                | Move to last line of document                                                                              |
|            | gg               | Move to first line of document                                                                             |
|            | H                | Move to top of page                                                                                        |
|            | L                | Move to bottom of page                                                                                     |
|            | M                | Move to center of page                                                                                     |
|            | ZZ               | Save and quit current buffer                                                                               |
|            | {                | Move to previous paragraph                                                                                 |
|            | }                | Move to next paragraph                                                                                     |
|            | ALT+c            | Delete all buffers except current buffer \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                               |
|            | ALT+q            | Quit without prompt \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | ALT+w            | Close current pane \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                     |
|            | CTRL+[           | Escape                                                                                                     |
|            | CTRL+^           | Navigate buffers                                                                                           |
|            | CTRL+b           | Move backwards one page                                                                                    |
|            | CTRL+f           | Move forwards one page                                                                                     |
|            | CTRL+h           | Navigate panes \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                         |
|            | CTRL+i           | Move forward to next position                                                                              |
|            | CTRL+o           | Move backward to previous position                                                                         |
|            | ENTER            | Clear highlighted search results                                                                           |
| Edit       |                  |                                                                                                            |
|            | .                | Repeat last shortcut that edited text                                                                      |
|            | =G               | Format indentation downwards to last line of document                                                      |
|            | a                | Insert after cursor                                                                                        |
|            | ce               | Replace until end of word                                                                                  |
|            | ci'              | Replace in between `'`                                                                                     |
|            | ciw              | Replace word                                                                                               |
|            | D                | Cut to end of current line                                                                                 |
|            | daB              | Cut `{}` block                                                                                             |
|            | dab              | Cut `()` block                                                                                             |
|            | dd               | Cut current line                                                                                           |
|            | dt'              | Cut to first occurrence of `'` on current line                                                             |
|            | i                | Insert before cursor                                                                                       |
|            | ii               | Escape \[INSERT MODE\] \[CUSTOM SHORTCUT\]                                                                 |
|            | O                | Append new line above current line                                                                         |
|            | o                | Append new line below current line                                                                         |
|            | r\<character\>   | Replace character under cursor with \<character\>                                                          |
|            | S                | Delete current line and insert                                                                             |
|            | s                | Delete character under cursor and insert                                                                   |
|            | u                | Undo                                                                                                       |
|            | x                | Delete character under cursor                                                                              |
|            | yiw              | Copy current word                                                                                          |
|            | yy               | Copy current line                                                                                          |
|            | ALT+j OR k       | Move current line, down or up \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                          |
|            | ALT+s            | Save current buffer \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | CTRL+d OR t      | Indent current line, left or right \[INSERT MODE\]                                                         |
|            | CTRL+n OR p      | Navigate auto-complete, down or up                                                                         |
|            | CTRL+r           | Redo                                                                                                       |
|            | CTRL+y           | Confirm auto-complete                                                                                      |
|            | SHIFT+, OR .     | Indent selected line, left or right \[VISUAL MODE\]                                                        |
| Select     |                  |                                                                                                            |
|            | V                | Activate linewise VISUAL MODE                                                                              |
| Command    |                  |                                                                                                            |
|            | /\<string\>      | Search in current buffer for \<string\> (`n` for next occurrence)                                          |
|            | :!\<command\>    | Run \<command\> in shell                                                                                   |
|            | :bd \[\<path\>\] | Delete current buffer or buffer at \<path\>                                                                |
| CoC        |                  |                                                                                                            |
|            | gd               | Jump to definition of code                                                                                 |
|            | gh               | Show tooltip for code \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                  |
|            | gr               | Show references for code                                                                                   |
|            | ALT+m            | Show problems \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                          |
|            | ALT+r            | Open Refactorings/Code Actions\[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                          |
|            | CTRL+SPACE       | Toggle auto-complete                                                                                       |
|            | F2               | Rename symbol \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                          |
|            | :CocUpdate       | Update extensions                                                                                          |
| Commentary |                  |                                                                                                            |
|            | gc2j             | Toggle line comment downwards 2 lines                                                                      |
|            | gcc              | Toggle line comment for current line                                                                       |
| EasyMotion |                  |                                                                                                            |
|            | SPACE            | Toggle EasyMotion \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                      |
| FZF        |                  |                                                                                                            |
|            | ALT+f            | Search in workspace \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | ALT+p            | Search for file \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                        |
|            | CTRL+j OR k      | Navigate search results, down or up (`ENTER` to open file, `CTRL+v` to open file in vertically split pane) |
|            | :Snippets        | Show available snippets for current filetype                                                               |
| NERDTree   |                  |                                                                                                            |
|            | m                | Open menu                                                                                                  |
|            | R                | Refresh tree                                                                                               |
|            | s                | Open file in vertically split pane                                                                         |
|            | ALT+d            | Reveal file in tree \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                    |
|            | ALT+t            | Toggle tree \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                                                            |
|            | :NERDTreeFind    | Reveal current buffer in tree                                                                              |
| Splitjoin  |                  |                                                                                                            |
|            | gJ               | Join block under cursor into line                                                                          |
|            | gS               | Split line under cursor into block                                                                         |
| Surround   |                  |                                                                                                            |
|            | cs})             | Replace `}` with `)` in between cursor                                                                     |
|            | ysiw'            | Surround current word with `'`                                                                             |
| UltiSnips  |                  |                                                                                                            |
|            | CTRL+j           | Move forwards one placeholder                                                                              |
|            | CTRL+k           | Move backwards one placeholder                                                                             |
|            | :UltiSnipsEdit   | Open snippets file for current filetype                                                                    |
| vim-plug   |                  |                                                                                                            |
|            | :PlugUpdate      | Update plugins                                                                                             |
|            | :PlugUpgrade     | Upgrade vim-plug                                                                                           |

## tmux

Inputs that are specific for tmux. Shortcuts and commands are prefixed with `CTRL+b`. Parameters are prefixed with `tmux`.

| Category  | Input              | Description                                             |
| --------- | ------------------ | ------------------------------------------------------- |
| Shortcut  |                    |                                                         |
|           | "                  | Split pane horizontally                                 |
|           | %                  | Split pane vertically                                   |
|           | ,                  | Rename current window                                   |
|           | 0..9               | Focus `x` window                                        |
|           | [                  | Activate scroll (`DOWN` or `UP` to scroll, `q` to exit) |
|           | c                  | Create new window                                       |
|           | n OR p             | Navigate windows, next or previous                      |
|           | {                  | Move current pane to left                               |
|           | LEFT or RIGHT      | Navigate panes, next or previous                        |
| Command   |                    |                                                         |
|           | :resize-pane -R 50 | Resize current pane towards right by 50 columns         |
|           | exit               | Exit current pane/window                                |
| Parameter |                    |                                                         |
|           | kill-session       | Kill current session                                    |
|           | kill-session -a    | Kill all sessions except current                        |
