{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.shell;
in {
  options.system.shell = {
    enable = lib.mkEnableOption "enable shell module";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        cd = "z";
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        nf = "nix flake update";
        hm = "home-manager -b bak switch --flake";
        nb = "sudo nixos-rebuild switch --flake";
        ls = "eza --icons";
      };

      ohMyZsh.enable = false;

      promptInit = "";

      interactiveShellInit = lib.mkMerge [
        (lib.mkBefore ''
          [[ -o interactive && -t 0 ]] && stty -echo 2>/dev/null

          printf '\e[2K\r'
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi
          typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
          typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
          typeset -g POWERLEVEL9K_DISABLE_GITSTATUS_UPGRADE=true
        '')
        # Runs after system /etc/zshrc.
        (lib.mkAfter ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh

          for f in "$HOME/.config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"; do
            [[ ! -f "$f" ]] || { source "$f"; break; }
          done
          eval "$(zoxide init zsh)"

          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          stty echo 2>/dev/null
          (( ! ''${+functions[p10k]} )) || p10k finalize
        '')
      ];
    };

    environment.systemPackages = [pkgs.zsh-abbr];

    users.defaultUserShell = pkgs.zsh;
    environment.shells = [pkgs.zsh];
  };
}
