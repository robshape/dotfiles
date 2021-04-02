# Vim for Visual Studio Code

Keyboard shortcuts for Vim inside Visual Studio Code.

| Category   | Input                | Description                                                               |
| ---------- | -------------------- | ------------------------------------------------------------------------- |
| Move       |                      |                                                                           |
|            | \$                   | Move to end of current line                                               |
|            | %                    | Move to matching character (`()`, `[]`, `{}`)                             |
|            | \*                   | Move to next occurrence of word under cursor                              |
|            | 0                    | Move to start of current line                                             |
|            | b                    | Move backwards to start of word                                           |
|            | e                    | Move forwards to end of word                                              |
|            | f'                   | Move to first occurrence of `'` on current line (`;` for next occurrence) |
|            | G                    | Move to last line of document                                             |
|            | gg                   | Move to first line of document                                            |
|            | H                    | Move to top of page                                                       |
|            | L                    | Move to bottom of page                                                    |
|            | M                    | Move to center of page                                                    |
|            | [{                   | Move to start of block                                                    |
|            | ]}                   | Move to end of block                                                      |
|            | {                    | Move to previous paragraph                                                |
|            | }                    | Move to next paragraph                                                    |
|            | CTRL+[               | Escape                                                                    |
|            | CTRL+b               | Move backwards one page                                                   |
|            | CTRL+f               | Move forwards one page                                                    |
|            | CTRL+i               | Move forward to next position                                             |
|            | CTRL+o               | Move backward to previous position                                        |
| Edit       |                      |                                                                           |
|            | .                    | Repeat last shortcut that edited text                                     |
|            | =G                   | Format indentation downwards to last line of document                     |
|            | a                    | Insert after cursor                                                       |
|            | ce                   | Replace until end of word                                                 |
|            | ci'                  | Replace in between `'`                                                    |
|            | ciw                  | Replace word                                                              |
|            | D                    | Cut to end of current line                                                |
|            | daB                  | Cut `{}` block                                                            |
|            | dab                  | Cut `()` block                                                            |
|            | dd                   | Cut current line                                                          |
|            | dt'                  | Cut to first occurrence of `'` on current line                            |
|            | i                    | Insert before cursor                                                      |
|            | ii                   | Escape \[INSERT MODE\] \[CUSTOM SHORTCUT\]                                |
|            | O                    | Append new line above current line                                        |
|            | o                    | Append new line below current line                                        |
|            | r\<character\>       | Replace character under cursor with \<character\>                         |
|            | S                    | Delete current line and insert                                            |
|            | s                    | Delete character under cursor and insert                                  |
|            | u                    | Undo                                                                      |
|            | x                    | Delete character under cursor                                             |
|            | yiw                  | Copy current word                                                         |
|            | yy                   | Copy current line                                                         |
|            | CTRL+d OR t          | Indent current line, left or right \[INSERT MODE\]                        |
|            | CTRL+r               | Redo                                                                      |
|            | SHIFT+, OR .         | Indent selected line, left or right \[VISUAL MODE\]                       |
| Select     |                      |                                                                           |
|            | V                    | Activate linewise VISUAL MODE                                             |
| Commentary |                      |                                                                           |
|            | gc2j                 | Toggle line comment downwards 2 lines                                     |
|            | gcc                  | Toggle line comment for current line                                      |
| EasyMotion |                      |                                                                           |
|            | SPACE                | Toggle EasyMotion \[NORMAL MODE\] \[CUSTOM SHORTCUT\]                     |
| Surround   |                      |                                                                           |
|            | cs})                 | Replace `}` with `)` in between cursor                                    |
|            | ysiw'                | Surround current word with `'`                                            |
| VSCodeVim  |                      |                                                                           |
|            | gd                   | Jump to definition of code                                                |
|            | gh                   | Show tooltip for code                                                     |
| VSCode     |                      |                                                                           |
|            | ALT+CLICK            | Add another cursor at click position                                      |
|            | ALT+DOWN or UP       | Move current line, down or up                                             |
|            | ALT+ESC              | Show auto-complete                                                        |
|            | ALT+SHIFT+DOWN or UP | Duplicate current line, down or up                                        |
|            | CMD+1..3             | Focus `x` pane                                                            |
|            | CMD+\                | Split pane vertically                                                     |
|            | CMD+b                | Toggle side bar                                                           |
|            | CMD+d                | Add another cursor at same word                                           |
|            | CMD+f                | Search in current file                                                    |
|            | CMD+k THEN z         | Toggle Zen mode                                                           |
|            | CMD+p                | Search for file (or `>` for actions and `@` for symbols)                  |
|            | CMD+q                | Quit without prompt                                                       |
|            | CMD+s                | Save current file                                                         |
|            | CMD+w                | Close current pane/tab                                                    |
|            | CMD+ALT+DOWN or UP   | Add another cursor, down or up                                            |
|            | CMD+ENTER            | Open file in vertically split pane                                        |
|            | CMD+SHIFT+e          | Focus file explorer                                                       |
|            | CMD+SHIFT+f          | Search in workspace                                                       |
|            | CTRL+\`              | Open/focus Terminal                                                       |
|            | CTRL+SHIFT+r         | Open Refactorings/Code Actions                                            |
|            | CTRL+TAB             | Navigate tabs                                                             |
|            | F2                   | Rename symbol                                                             |
|            | SHIFT+ESC            | Hide auto-complete                                                        |
