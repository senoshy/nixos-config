{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home.kitty;
  palette = import ../theme/palette.nix {inherit lib;};
  c = palette.colors;

  theme = ''
    background #${c.consoleBg}
    foreground #${c.consoleFg}
    cursor #${c.consoleCursor}
    cursor_text_color #${c.consoleBg}
    selection_background #${c.selectionBg}
    selection_foreground #${c.selectionFg}
    ${lib.concatStringsSep "\n" (lib.genList (i: "color${toString i} #${c."vt${toString i}"}") 16)}
  '';
in {
  options.home.kitty = {
    enable = lib.mkEnableOption "enable kitty config management";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.kitty];
    home.file."${config.home.homeDirectory}/.config/kitty/kitty.conf".source = ./kitty.conf;
    home.file."${config.home.homeDirectory}/.config/kitty/colors.conf".text = theme;
  };
}
