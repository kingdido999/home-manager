# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Home Manager configuration repository for managing a macOS development environment using Nix. Home Manager declaratively manages user-level packages, dotfiles, and application configurations.

## Essential Commands

### Applying Configuration Changes
```bash
home-manager switch     # Apply configuration and switch to new generation
hs                      # Alias for home-manager switch
```

### Editing Configuration
```bash
home-manager edit       # Edit home.nix in default editor
he                      # Alias for home-manager edit
hx ~/.config/home-manager  # Open config directory in Helix
hee                     # Alias for above
```

### Validation
```bash
home-manager build      # Build configuration without switching
home-manager switch -n  # Dry run - preview changes without applying
```

### Rollback
```bash
home-manager generations  # List all generations
home-manager switch --rollback  # Roll back to previous generation
```

## Architecture

### Core Configuration (home.nix)
The `home.nix` file is the main configuration entry point structured as a Nix module with these sections:

1. **Nix settings**: Enables flakes and nix-command experimental features
2. **User identity**: Dynamically set from environment variables
3. **Package installation**: Declarative package list in `home.packages`
4. **Dotfile management**: Symlinks managed via `home.file`
5. **Shell configuration**: Aliases defined in `home.shellAliases`
6. **Program-specific configs**: Structured configurations for Git, Fish, and Helix

### Application Configurations

**WezTerm** (`wezterm.lua`):
- Managed via `home.file.".wezterm.lua".source`
- Symlinked to home directory on activation
- Uses Solarized Light theme and Fira Code font
- Custom keybindings for pane navigation (Ctrl+Shift+hjkl)

**AeroSpace** (`aerospace.toml`):
- Tiling window manager configuration for macOS
- Not symlinked by Home Manager (manual deployment to `~/.aerospace.toml`)
- Vim-style navigation (Alt+hjkl)
- Workspace shortcuts: Alt+{a,d,f,s}
- Service mode: Alt+Shift+; for advanced operations

**Helix** (configured in home.nix):
- Settings embedded in `programs.helix.settings`
- Solarized Light theme
- jj mapping for escaping insert mode
- Enabled soft-wrap and hidden file picker

**Themes** (`themes/solarized_light.toml`):
- Custom Helix theme file (not automatically loaded by current config)
- Contains Solarized Light color scheme definitions

### Git Configuration
- Personal config in home.nix with conditional work config
- Work repositories (under `~/work/`) use separate `.gitconfig-work`
- Delta pager installed for enhanced diffs

### Shell Environment
- Fish shell as default (`$SHELL`)
- Helix as default editor (`$EDITOR`)
- Hydro prompt and fzf-fish plugins
- PATH setup includes Nix profiles, user bins, and system paths
- Git aliases: ga, gc, gd, gs, gp, gpl

## Making Changes

### Adding New Packages
Add to the `home.packages` list in home.nix:
```nix
home.packages = [
  pkgs.packageName
  # ...
];
```

### Modifying Dotfiles
1. Edit the source file in this repository (e.g., `wezterm.lua`)
2. Run `home-manager switch` to symlink changes to home directory

### Program Configuration
For programs with Home Manager modules (like git, fish, helix), edit their structured configuration in the `programs.<name>` sections rather than managing raw config files.

### AeroSpace Configuration
The `aerospace.toml` file must be manually copied to `~/.aerospace.toml` as it's not currently managed by Home Manager's `home.file`.

## Important Notes

- State version is locked to "23.11" - do not change without reading Home Manager release notes
- Username and home directory are dynamically set from environment variables
- Experimental features (nix-command, flakes) are enabled
- Shell initialization adds multiple PATH entries in Fish's shellInit
