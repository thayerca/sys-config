# ------------------------------------------------------------------------------
# Brewfile — Homebrew formulae and casks
# ------------------------------------------------------------------------------
# What it does:
#   Declares all Homebrew packages (CLI tools, shell, dev tools, languages,
#   fonts, casks). Used by setup.sh via: brew bundle --file="$REPO/Brewfile".
#
# How to interact:
#   Edit this file to add/remove packages. After changing, run:
#   brew bundle --file=~/sys-config/Brewfile (or your repo path).
#   To regenerate from current install: brew bundle dump --force --describe --file=Brewfile
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Taps (third-party Homebrew repositories)
# ------------------------------------------------------------------------------
tap "dagger/tap"              # Dagger CI/CD pipeline tool
tap "derailed/k9s"            # K9s Kubernetes TUI
tap "go-task/tap"             # Task task runner
tap "homebrew/bundle"         # Support for using Brewfiles
tap "homebrew/services"       # Manage background services via Homebrew
tap "osx-cross/arm"           # Cross-compilation toolchains for ARM

# ------------------------------------------------------------------------------
# Core CLI Tools
# ------------------------------------------------------------------------------
brew "ack"                    # Search tool like grep, optimized for programmers
brew "asciinema"              # Record and share terminal sessions
brew "bat"                    # Clone of cat(1) with syntax highlighting and Git integration
brew "beautysh"               # Bash beautifier
brew "brew-cask-completion"   # Fish/zsh completion for brew cask commands
brew "bzip2"                  # Freely available high-quality data compressor
brew "coreutils"              # GNU core utilities (grealpath, gsort, etc.)
brew "cscope"                 # Code browsing and navigation tool
brew "curl"                   # Get a file from HTTP, HTTPS or FTP servers
brew "eza"                    # Modern, maintained replacement for ls with icons and colors
brew "fnm"                    # Fast and simple Node.js version manager
brew "fzf"                    # Command-line fuzzy finder written in Go
brew "jq"                     # Lightweight and flexible command-line JSON processor
brew "ripgrep"                # Search tool like grep and The Silver Searcher
brew "tree"                   # Display directories as trees (with optional color/HTML output)
brew "wget"                   # Internet file retriever
brew "xz"                     # General-purpose data compression with high compression ratio
brew "zstd"                   # Zstandard real-time compression algorithm

# ------------------------------------------------------------------------------
# Shell & Terminal Enhancements
# ------------------------------------------------------------------------------
brew "bash-completion"        # Programmable completion for Bash
brew "direnv"                 # Load/unload environment variables based on $PWD
brew "mosh"                   # Remote terminal application (mobile shell)
brew "ranger"                 # Vim-like file browser for the terminal
brew "stow"                   # Organize software neatly under a single directory tree
brew "terminal-notifier"      # Send macOS User Notifications from the command-line
brew "tmux"                   # Terminal multiplexer for persistent sessions
brew "zsh"                    # UNIX shell (Z shell) with scripting features
brew "zsh-autosuggestions"    # Fish-like fast/unobtrusive autosuggestions for zsh
brew "zsh-completions"        # Additional completion definitions for zsh
brew "zsh-syntax-highlighting" # Fish shell-like syntax highlighting for zsh

# ------------------------------------------------------------------------------
# Developer Tools
# ------------------------------------------------------------------------------
brew "commitizen"             # Defines a standard way of committing (conventional commits)
brew "gh"                     # GitHub command-line tool
brew "git-delta"              # Syntax-highlighting pager for git and diff output
brew "hub"                    # Add GitHub support to git on the command-line
brew "lazygit"                # Simple terminal UI for git commands
brew "pre-commit"             # Framework for managing multi-language pre-commit hooks
brew "shellcheck"             # Static analysis and lint tool for (ba)sh scripts
brew "stylua"                 # Opinionated Lua code formatter
brew "tree-sitter"            # Incremental parsing library for editors

# ------------------------------------------------------------------------------
# Languages & Runtimes
# ------------------------------------------------------------------------------
brew "go"                     # Open source programming language (Go)
brew "macvim"                 # GUI for vim, made for macOS
brew "neovim"                 # Ambitious Vim-fork focused on extensibility and agility
brew "node"                   # Open-source, cross-platform JavaScript runtime (Node.js)
brew "r"                      # Software environment for statistical computing
brew "rust"                   # Safe, concurrent, practical systems language
brew "yarn"                   # JavaScript package manager

# ------------------------------------------------------------------------------
# Python Ecosystem
# ------------------------------------------------------------------------------
brew "ipython"                # Interactive computing in Python
brew "pipenv"                 # Python dependency management via Pipfile
brew "poetry"                 # Python package management tool
brew "pyenv"                  # Python version management
brew "pyenv-virtualenv"       # Pyenv plugin to manage virtualenv
brew "python@3.10"            # Interpreted, interactive, object-oriented programming language
brew "python@3.11"            # Interpreted, interactive, object-oriented programming language
brew "python@3.13"            # Interpreted, interactive, object-oriented programming language
brew "virtualenv"             # Tool for creating isolated virtual Python environments

# ------------------------------------------------------------------------------
# System Libraries & Dependencies
# ------------------------------------------------------------------------------
brew "llvm"                   # Next-gen compiler infrastructure
brew "openblas"               # Optimized linear algebra library (for R, NumPy, etc.)
brew "zlib"                   # General-purpose lossless data-compression library

# ------------------------------------------------------------------------------
# Databases
# ------------------------------------------------------------------------------
brew "postgresql@14"          # Object-relational database system
brew "sqlite"                 # Lightweight, embedded SQL database engine
brew "mycli"                  # MySQL CLI

# ------------------------------------------------------------------------------
# Containers & Kubernetes
# ------------------------------------------------------------------------------
brew "dagger"                 # Portable devkit for CI/CD pipelines
brew "docker", link: false    # Pack, ship and run applications as lightweight containers
brew "docker-completion"      # Bash/zsh completion for Docker CLI
brew "hadolint"               # Smarter Dockerfile linter to validate best practices
brew "helm"                   # Kubernetes package manager
brew "k9s"                    # Kubernetes CLI to manage clusters (TUI)
brew "kubernetes-cli"         # Kubernetes command-line interface (kubectl)

# ------------------------------------------------------------------------------
# Infrastructure & DevOps
# ------------------------------------------------------------------------------
brew "go-task"                # Task runner/build tool (simpler than Make)
brew "terraform"              # Tool to build, change, and version infrastructure

# ------------------------------------------------------------------------------
# Documentation & Linting
# ------------------------------------------------------------------------------
brew "markdown"               # Markdown processing tools
brew "markdownlint-cli"       # CLI for Markdown style checker and lint tool
brew "marksman"               # Language Server Protocol for Markdown
brew "mdcat"                  # Show markdown documents on text terminals
brew "yamllint"               # Linter for YAML files

# ------------------------------------------------------------------------------
# Fonts
# ------------------------------------------------------------------------------
cask "font-hack-nerd-font"    # Hack font patched with Nerd Fonts icons
cask "font-iosevka"           # Flexible typeface for code, optimized for programming

# ------------------------------------------------------------------------------
# GUI Applications (Casks)
# ------------------------------------------------------------------------------
cask "dbeaver-community"      # Universal database tool and SQL client
cask "disk-inventory-x"       # Disk usage utility and visualizer
cask "docker-desktop"         # App to build and share containerised applications
cask "dockfix"                # Dock replacement and customization
cask "gcloud-cli"             # Set of tools to manage Google Cloud resources (formerly google-cloud-sdk)
cask "kitty"                  # GPU-based terminal emulator
cask "mark-text"              # Open-source Markdown editor with live preview
cask "notion"                 # App to write, plan, collaborate, and get organised
cask "sublime-text"           # Text editor for code, markup and prose
cask "tuple"                  # Remote pair programming app
cask "zoom"                   # Video communication and virtual meeting platform
