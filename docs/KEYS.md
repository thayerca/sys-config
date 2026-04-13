# Keys — Task-Oriented Keybinding Reference

Task-first quick reference. Find what you want to do, get the exact keys. For full context on any workflow see [WORKFLOWS.md](WORKFLOWS.md); for a complete keybinding list by tool see [CHEATSHEET.md](CHEATSHEET.md).

---

## Navigation

| I want to… | Keys |
|------------|------|
| Open a file by name | `<Space>ff` → type → Enter |
| Search for text across the project | `<Space>fs` → type → Enter |
| Search for the word under my cursor | `<Space>fc` |
| Jump to a recent file | `<Space>fr` |
| Jump to a function/class by name | `<Space>rA` |
| Go to definition | `gd` |
| Go to type definition | `gt` |
| See all references to a symbol | `gR` |
| Read hover docs for something | `K` |
| Jump to a visible spot on screen | `<Space>j` → type label |
| Jump between my 4 pinned files | `<Space>1` `<Space>2` `<Space>3` `<Space>4` |
| Pin the current file to harpoon | `<Space>a` |
| Open the file tree | `<Space>ee` |
| Rename/move/delete files in-place | `<Space>o` (Oil) |

---

## Editing

| I want to… | Keys |
|------------|------|
| Find and replace across the project | `<Space>S` |
| Find and replace only in this file | `<Space>sf` |
| Search for word under cursor + replace | `<Space>sw` → edit in Spectre |
| Rename a symbol everywhere (LSP) | `<Space>rn` |
| Extract selected code to a function | visual select → `<Space>re` |
| Extract selected code to a variable | visual select → `<Space>rv` |
| Inline a variable | `<Space>ri` |
| Toggle a line comment | `gcc` |
| Toggle a block comment | `gbc` |
| Comment a range | `gc` + motion |
| Wrap word in quotes / brackets | `ys` + motion + char (e.g. `ysiw"`) |
| Change surrounding quotes/brackets | `cs` + old + new (e.g. `cs"'`) |
| Delete surrounding quotes/brackets | `ds` + char |
| Paste from earlier yanks | `p` then `<C-n>` / `<C-p>` to cycle |
| Pick any past yank | `<Space>fy` |
| See full undo history visually | `<Space>uu` |
| Clear search highlights | `<Space>nh` |

---

## Code intel

| I want to… | Keys |
|------------|------|
| See diagnostics for the current line | `<Space>d` |
| Jump to next / previous diagnostic | `]d` / `[d` |
| Open the diagnostics panel | `<Space>xx` |
| Run a code action (fix / import / etc.) | `<Space>ca` |
| Format the file | `<Space>mp` |
| Toggle inlay hints | `<Space>uh` |
| Open the symbol outline sidebar | `<Space>ra` |

---

## Git

| I want to… | Keys |
|------------|------|
| Stage, commit, push (full UI) | `<Space>lg` → Space to stage → `c` commit → `P` push |
| See a diff of all my changes vs HEAD | `<Space>gd` |
| Stage one hunk | `]h` to navigate → `<Space>hs` |
| Stage the whole file | `<Space>hS` |
| Reset a hunk | `<Space>hr` |
| Preview a hunk inline | `<Space>hp` |
| See blame for the current line | `<Space>hb` |
| Toggle blame column | `<Space>hB` |
| See this file's commit history | `<Space>gh` |
| See the whole repo's history | `<Space>gH` |
| See one file's commits in quickfix | `<Space>gL` |
| Interactive rebase | `<Space>gr` → type base branch → Enter |
| Resolve a merge conflict | `<Space>gd` → edit result buffer → `<Space>hS` → `<Space>gc` |
| Open a PR list | `<Space>go` |
| Review a PR (diff + files) | `<Space>go` → pick PR → `<Space>pd` / `<Space>pf` |
| Add a review comment | (inside PR buffer) `<Space>ca` |
| Approve / request changes | `<Space>va` / `<Space>vr` |
| Submit review | `<Space>vs` |
| Checkout a PR branch | `<Space>po` |

---

## Debugging

| I want to… | Keys |
|------------|------|
| Set a breakpoint | `<Space>db` |
| Set a conditional breakpoint | `<Space>dB` |
| Start / continue the session | `<Space>dc` |
| Step over | `<Space>dn` |
| Step into | `<Space>di` |
| Step out | `<Space>do` |
| Evaluate an expression / variable | `<Space>de` (normal or visual) |
| Open the REPL | `<Space>dr` |
| Toggle DAP UI | `<Space>du` |
| Stop the session | `<Space>dx` |
| Debug the test under cursor | `<Space>Td` |

---

## Testing

| I want to… | Keys |
|------------|------|
| Run the test under cursor | `<Space>Tr` |
| Run all tests in this file | `<Space>TT` |
| See all test results | `<Space>Ts` |
| Read output for the nearest test | `<Space>To` |
| Stop tests | `<Space>Tx` |

---

## Splits, tabs, windows

| I want to… | Keys |
|------------|------|
| Split vertically | `<Space>sv` |
| Split horizontally | `<Space>sh` |
| Move between splits (+ tmux panes) | `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` |
| Maximize the current split | `<Space>sm` |
| Close the current split | `<Space>sx` |
| New tab | `<Space>to` |
| Close tab | `<Space>tx` |
| Next / previous tab | `<Tab>` / `<S-Tab>` |
| Open current buffer in new tab | `<Space>tf` |

---

## Tmux

| I want to… | Keys |
|------------|------|
| Switch to another project | `Ctrl-A f` (sessionizer fzf picker) |
| Switch between sessions | `Ctrl-A s` |
| New tmux window | `Ctrl-A c` |
| Next / previous window | `Ctrl-A n` / `Ctrl-A p` |
| Split pane right | `Ctrl-A |` |
| Split pane down | `Ctrl-A -` |
| Zoom a pane to fullscreen | `Ctrl-A z` |
| Copy text in tmux | `Ctrl-A v` → `v` to select → `y` to yank |
| Save session to disk | `Ctrl-A Ctrl-S` |
| Restore session from disk | `Ctrl-A Ctrl-R` |

---

## Claude Code

| I want to… | Keys |
|------------|------|
| Open / close Claude panel | `<Space>cc` |
| Switch focus editor ↔ Claude | `Alt-w` |
| Resume my last Claude session | `<Space>cr` |
| Give Claude the current buffer | `<Space>cb` |
| Send a selection to Claude | visual select → `<Space>cs` |
| Accept Claude's diff | `<Space>cA` |
| Deny Claude's diff | `<Space>cd` |
| Switch Claude model | `<Space>cm` |

---

## Session & workspace

| I want to… | Keys |
|------------|------|
| Restore session for this directory | `<Space>qs` |
| Restore last session | `<Space>ql` |
| Quit without saving session | `<Space>qq` |
| Toggle floating terminal | `<Space>tt` |
| Center the buffer (writing mode) | `<Space>z` |
| Reload tmux config | `Ctrl-A r` |
| Reload zsh config | `sz` (shell alias) |
