{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.rofi;

  # rofi silently ignores a missing @import, so the static palette at the top
  # of config.rasi stays in place until wallust has generated one.
  wallustColors = "${config.home.homeDirectory}/.cache/wallust/colors-rofi.rasi";
in {
  options.home.rofi = {
    enable = lib.mkEnableOption "enable rofi config";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi.enable = true;

    # The import must come last: later definitions win, and rasi keeps
    # `@name` references live (they become var(name)), so the rules above pick
    # up the imported values too.
    home.file.".config/rofi/config.rasi".text = ''
      ${builtins.readFile ./config.rasi}
      @import "${wallustColors}"
    '';
  };
}
