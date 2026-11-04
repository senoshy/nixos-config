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
      syntaxHighlighting.enable = true;

      shellAliases = {
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
      };

      ohMyZsh.enable = false;

      promptInit = "";

      interactiveShellInit = lib.mkMerge [
        (lib.mkBefore ''
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi
          typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
          typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
          typeset -g POWERLEVEL9K_DISABLE_GITSTATUS_UPGRADE=true
        '')

        (lib.mkOrder 1000 ''
          (( $+commands[eza] )) && alias ls='eza'

          typeset -g ABBR_QUIET=1
          source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh
          abbr nf='nix flake update'
          abbr nb='sudo nixos-rebuild switch --flake'
          abbr hm='home-manager -b bak switch --flake'
          abbr nu='nix flake update && git add flake.lock && git commit -m "flake.lock: Update" flake.lock'
          abbr nd='nix develop'
          eval "$(zoxide init zsh --cmd cd)"

          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
        '')

        (lib.mkAfter ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          for f in "$HOME/.config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"; do
            [[ ! -f "$f" ]] || { source "$f"; break; }
          done

          typeset -g POWERLEVEL9K_MODE=ascii
          typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline prompt_char)
          typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
          typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
          typeset -g POWERLEVEL9K_SINGLE_LINE=false
          typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=${"''"}
          typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=${"''"}
          typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
          typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=6
          typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=1
          typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='$'
          typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='#'
          typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION=':'
          typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='>'
          typeset -g POWERLEVEL9K_DIR_FOREGROUND=6
          typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=6
          typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=6
          typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=2
          typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=3
          typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=2
          typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
          typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=1
          typeset -g POWERLEVEL9K_INSTANT_PROMPT_FOREGROUND=6

          # p10k paints a background on the prompt segments (dir is blue, prompt
          # char and status are black). Kitty only renders cells with the
          # default terminal background as translucent, so those segments show
          # up as opaque boxes. Keep every segment on the default background.
          typeset -g POWERLEVEL9K_BACKGROUND=

          (( ! ''${+functions[p10k]} )) || p10k finalize
        '')
      ];
    };

    environment.systemPackages = [pkgs.zsh-abbr];

    users.defaultUserShell = pkgs.zsh;
  };
}
