{ config, pkgs, ... }:

{
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Editor
    pkgs.helix

    # Shell
    pkgs.fish
    pkgs.fzf
    pkgs.fd
    pkgs.bat

    # Fonts
    pkgs.fira-code

    # LSP
    pkgs.nil

    # Data Visualization
    pkgs.d2

    # Terminal
    pkgs.wezterm

    # Git
    pkgs.delta
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".wezterm.lua".source = ./wezterm.lua;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pengchengding/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
    SHELL = "${pkgs.fish}/bin/fish";
  };

  home.shellAliases = {
    ga = "git add .";
    gc = "git commit -m";
    gd = "git diff";
    gs = "git status";
    gp = "git push";
    gpl = "git pull";

    hee = "hx ~/.config/home-manager";
    he = "home-manager edit";
    hs = "home-manager switch";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Pengcheng Ding";
    userEmail = "info@pcding.com";

    extraConfig = {
      # Work repo config
      "includeIf \"gitdir:~/work/\"" = {
        path = "~/.gitconfig-work";
      };
    };
  };

  programs.fish = {
    enable = true;
    plugins = [
      { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
    shellInit = ''
      set -x PATH /nix/var/nix/profiles/default/bin $PATH
      set -x PATH $HOME/.nix-profile/bin $PATH
      set -x PATH $HOME/bin $PATH
      set -x PATH $HOME/.local/bin $PATH
      set -x PATH /usr/local/bin $PATH
    '';
  };

  programs.helix = {
    enable = true;

    settings = {
      theme = "solarized_light";

      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      
        file-picker = {
          hidden = false;
        };

        soft-wrap = {
          enable = true;
        };
      };

      keys.insert = {
        j = { j = "normal_mode"; };
      };     
    };
  };

}
