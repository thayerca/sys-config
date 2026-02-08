# Plugin Recommendations (Neovim & Tmux)

This document listed suggested plugins; **many are now installed** (see “Currently installed” below). The tables below still describe each plugin; entries that are installed are marked.

**Doc index:** [INDEX.md](INDEX.md)

---

**Neovim:** Add a new file under `nvim/lua/cthayer/plugins/` returning a lazy.nvim spec, then restart Neovim so lazy installs it.

**Tmux:** Add `set -g @plugin 'author/name'` to `tmux/.tmux.conf`, then run **prefix + I** to install via TPM.

---

## Currently installed (from recommendations)

**Neovim (keymaps; leader = Space):**
- **noice.nvim** + **nvim-notify** — cmdline/message UI; no extra keymaps.
- **no-neck-pain** — `<leader>z` toggle.
- **mini.animate** — no keymap.
- **telescope-fzf-native**, **telescope-file-browser**, **telescope-project** — `<leader>fe` (file browser), `<leader>fp` (projects).
- **harpoon** — `<leader>a` (add), `<leader>1`–`<leader>4` (go to file), `<leader>hm` (menu).
- **flash.nvim** — `<leader>j` (jump to label).
- **nvim-treesitter-textobjects** — `]f`/`[f`, `]c`/`[c`, `vaf`, `vac`, etc.
- **refactoring.nvim** — `<leader>re`/`rv` (extract), `<leader>ri` (inline), `<leader>rM` (menu).
- **inc-rename.nvim** — uses existing `<leader>rn` (LSP rename with inline preview).
- **lsp-inlayhints.nvim** — `<leader>uh` (toggle inlay hints).
- **lsp_signature** — no keymap; shows on type.
- **toggleterm.nvim** — `<leader>tt` (toggle terminal).
- **oil.nvim** — `<leader>o` (edit directory).
- **undotree** — `<leader>uu` (toggle undotree).

**Tmux:**
- **tmux-resurrect** — save: prefix + Ctrl-s; restore: prefix + Ctrl-r.
- **tmux-continuum** — auto-save every 15 min; restore on server start (`@continuum-restore 'on'`).

**Not added (optional):** vim-be-good, tmux-sessionizer, tmux-battery, tmux-cpu, tmux-mode-indicator (Catppuccin may already show battery). nvim-surround was already present; no second surround plugin added.

---

## Neovim (reference)

### UI / UX

| Plugin                | What it does                                                            | Why useful                                                       |
| --------------------- | ----------------------------------------------------------------------- | ---------------------------------------------------------------- |
| **noice.nvim**        | Replaces cmdline, search, and messages with a minimal popup UI.         | Cleaner feedback and less flicker. **Installed.** |
| **notify.nvim**       | Replaces vim.notify with a nice notification popup.                     | Better visibility for LSP/plugin messages. **Installed.** |
| **no-neck-pain.nvim** | Keeps the current buffer centered with padding when the window is wide. | Reduces eye travel. **Installed** (`<leader>z`). |
| **mini.animate**      | Adds subtle animations for scroll, cursor, and window moves.            | Smoother feel. **Installed.** |

### Navigation / Files

| Plugin                          | What it does                                        | Why useful                                                 |
| ------------------------------- | --------------------------------------------------- | ---------------------------------------------------------- |
| **telescope-fzf-native**        | Native fzf sorter for Telescope.                    | Faster fuzzy matching. **Installed.** |
| **telescope-file-browser.nvim** | Browse and create files/dirs from Telescope.        | **Installed** (`<leader>fe`). |
| **harpoon**                     | Pin a few files and jump between them with one key. | **Installed** (`<leader>a`, `1`–`4`, `hm`). |
| **flash.nvim**                  | Label-based jump (like EasyMotion / Hop).           | **Installed** (`<leader>j`). |

### Editing

| Plugin                              | What it does                                          | Why useful                                                                      |
| ----------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------- |
| **nvim-treesitter-textobjects**     | Text objects (function, class, block) via Treesitter. | **Installed** (`]f`/`[f`, `vaf`, etc.). |
| **refactoring.nvim**                | Extract variable/function, inline, etc.               | **Installed** (`<leader>re`, `rv`, `ri`, `rM`). |
| **nvim-surround** (or keep current) | Change/delete/add surroundings (quotes, brackets).    | You already have surround; no second port added. |

### LSP / Diagnostics

| Plugin                  | What it does                                  | Why useful                            |
| ----------------------- | --------------------------------------------- | ------------------------------------- |
| **inc-rename.nvim**     | Inline rename preview while typing.           | **Installed** (uses `<leader>rn`). |
| **lsp-inlayhints.nvim** | Inlay hints (parameter names, types).         | **Installed** (`<leader>uh` toggle). |
| **lsp_signature**       | Show function signature and docs as you type. | **Installed** (shows on type). |

### AI / Completions

| Plugin                                | What it does                                        | Why useful                                             |
| ------------------------------------- | --------------------------------------------------- | ------------------------------------------------------ |
| **copilot.lua** or **GitHub Copilot** | AI completions and chat (you have copilot already). | You can add more keymaps or chat UI plugins if needed. |

### Sessions / Project

| Plugin                     | What it does                                                | Why useful               |
| -------------------------- | ----------------------------------------------------------- | ------------------------ |
| **telescope-project.nvim** | Switch between “projects” (e.g. recent dirs or saved list). | **Installed** (`<leader>fp`). |

### Terminal

| Plugin              | What it does                        | Why useful                                                  |
| ------------------- | ----------------------------------- | ----------------------------------------------------------- |
| **toggleterm.nvim** | Floating or split terminal toggles. | **Installed** (`<leader>tt`). |

### Misc

| Plugin          | What it does                                          | Why useful                             |
| --------------- | ----------------------------------------------------- | -------------------------------------- |
| **oil.nvim**    | Edit filesystem (rename, create, delete) as a buffer. | **Installed** (`<leader>o`). |
| **undotree**    | Visualize and jump in the undo tree.                  | **Installed** (`<leader>uu`). |
| **vim-be-good** | Mini-games for vim motions.                           | Optional; not installed. |

---

## Tmux

| Plugin                            | What it does                                  | Why useful                                            |
| --------------------------------- | --------------------------------------------- | ----------------------------------------------------- |
| **tmux-sessionizer** (or similar) | Fuzzy find or quick-switch sessions.          | Optional; tmux-fzf can cover session switch. |
| **tmux-resurrect**                | Save/restore pane layout and commands.        | **Installed** (prefix+Ctrl-s / Ctrl-r). |
| **tmux-continuum**                | Auto-save and restore (works with resurrect). | **Installed** (15 min auto-save; restore on start). |
| **tmux-battery**                  | Battery status in status line.                | Optional (Catppuccin may include). |
| **tmux-cpu**                      | CPU usage in status line.                     | Optional. |
| **tmux-mode-indicator**           | Show current mode (normal vs copy, etc.).     | Optional. |

---

## How to add one

**Neovim (example: noice.nvim)**

1. Create `nvim/lua/cthayer/plugins/noice.lua`:
   ```lua
   return {
     "folke/noice.nvim",
     event = "VeryLazy",
     dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
     config = function()
       require("noice").setup({
         -- your opts
       })
     end,
   }
   ```
2. Restart Neovim; lazy will install it.

**Tmux (example: tmux-resurrect)**

1. In `tmux/.tmux.conf`, add:
   ```text
   set -g @plugin 'tmux-plugins/tmux-resurrect'
   ```
2. Reload: prefix + r, then prefix + I to install.

After adding plugins, consider updating this file with a short note so future-you knows what was added and why.
