{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.home.zsh;
in {
  options.home.zsh = {
    enable = lib.mkEnableOption "enable zsh module";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initExtraFirst = ''
        if [[ -r "${"$"}{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${"$"}{(%):-%n}.sh" ]]; then
          source "${"$"}{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${"%"}{(%):-%n}.sh"
        fi
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
        typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      '';

      initExtra = ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        eval "$(zoxide init zsh)"

        alias cd='z'
        alias gs='git status'
        alias ga='git add'
        alias gc='git commit'
        alias gp='git push'
        alias nf='nix flake update'
        alias hm='home-manager -b bak switch --flake'
        alias nb='sudo nixos-rebuild switch --flake'
        alias ls='eza --icons'

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
    };
    home.package = with pkgs; [zsh-powerlevel10k];
  };
}
