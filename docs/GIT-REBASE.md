# Interactive rebase guide

This repo uses **vim-fugitive** and **LazyGit** (CLI + Neovim plugin). LazyGit is installed via Homebrew (`brew "lazygit"` in the Brewfile); open it from Neovim with `<Space>lg` or from the shell with `lg` (alias) or `lazygit`.

**Doc index:** [INDEX.md](INDEX.md)

---

## Quick reference

| Where        | How |
|-------------|-----|
| **Fugitive** | `<Space>gr` → type branch (e.g. `main`) → Enter. Edit the todo list in the buffer, save and close to run. |
| **LazyGit**  | Branches view → select branch → `r` (rebase) or use the rebase flow from the commits list. |
| **Terminal** | `git rebase -i main` (or your base branch). |

---

## With vim-fugitive (Neovim)

1. **Start interactive rebase**  
   Press `<Space>gr`, type the base branch (e.g. `main` or `origin/main`), press Enter.  
   Fugitive opens a buffer with the rebase todo list (pick, reword, squash, etc.).

2. **Edit the todo list**  
   - Change the first word of each line to the action you want:
     - `pick` — keep commit as-is
     - `reword` (or `r`) — keep commit but change message
     - `edit` (or `e`) — stop for amending
     - `squash` (or `s`) — fold into previous commit, combine messages
     - `fixup` (or `f`) — fold into previous, drop this message
     - `drop` (or `d`) — remove commit
   - Reorder lines to reorder commits.  
   - Save and close the buffer (`:wq` or `ZZ`) to run the rebase.

3. **If you chose `reword` or `edit`**  
   Git will stop at that commit. Change the message (reword) or amend (edit), then run `:G rebase --continue` (or from terminal: `git rebase --continue`). Use `:G rebase --abort` to cancel the whole rebase.

4. **Resolve conflicts**  
   If rebase stops due to conflicts, fix the files, stage with gitsigns (`<Space>hs` etc.) or `:Gwrite`, then `:G rebase --continue`.

---

## With LazyGit

1. Open LazyGit: `<Space>lg` (repo) or `lg` in the terminal.
2. **Option A — Rebase current branch onto another**  
   - Go to the **Branches** panel.  
   - Select the branch you want to rebase onto (e.g. `main`).  
   - Press `r` (rebase) or use the menu to start a rebase onto that branch.  
   - If LazyGit supports interactive rebase in the UI, follow its prompts to pick/reword/squash.

3. **Option B — Interactive from commits**  
   - In the **Local branches** or **Commits** view, find the base commit.  
   - Use the rebase action (often `r` or context menu) and choose “Interactive rebase” if available.  
   - Edit the todo list in the panel or in the editor (if LazyGit opens one).

LazyGit’s exact keys can vary by version; press `?` inside LazyGit for the keybindings.

---

## Terminal (no Neovim)

```bash
git rebase -i main   # or origin/main, or any base ref
```

An editor (e.g. Neovim) opens the todo list. Edit as above, save and close. Then:

- `git rebase --continue` — after resolving conflicts or after reword/edit
- `git rebase --skip` — skip current commit (use with care)
- `git rebase --abort` — cancel and restore the branch to before the rebase

---

## Tips

- **Rebase onto latest main:** `<Space>gr` → `origin/main` → Enter (after fetching).
- **Squash last N commits:** Start rebase onto the commit before them; change all but the first to `squash` or `fixup`.
- **Only change messages:** Use `reword` for those commits.
- **Safety:** Rebasing rewrites history. Avoid rebasing commits that are already pushed and shared; if you do, force-push (`git push --force-with-lease`) and coordinate with anyone using that branch.
