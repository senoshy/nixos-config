{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.home.browsers;
  userJSContent =
    # (builtins.readFile ./betterfox.js) + "\n" +
    builtins.readFile ./user.js;

  parseUserJS = content: let
    lines = lib.splitString "\n" content;
    validLines =
      builtins.filter (
        line: (builtins.match ''user_pref\("([^"]+)",[[:space:]]*(.+)\);'' line) != null
      )
      lines;
    toAttr = line: let
      match = builtins.match ''user_pref\("([^"]+)",[[:space:]]*(.+)\);'' line;
      key = builtins.elemAt match 0;
      rawValue = lib.strings.removeSuffix ";" (builtins.elemAt match 1);
      value =
        if rawValue == "true"
        then true
        else if rawValue == "false"
        then false
        else if (builtins.match "^[0-9]+$") rawValue != null
        then lib.toInt rawValue
        else if (builtins.match ''^".*"$'' rawValue) != null
        then lib.strings.removePrefix "\"" (lib.strings.removeSuffix "\"" rawValue)
        else rawValue;
    in {
      name = key;
      inherit value;
    };
  in
    lib.listToAttrs (map toAttr validLines);
in {
  options.home.browsers = {
    enable = lib.mkEnableOption "enable firefox module";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = lib.mkDefault true;
      package = pkgs.firefox;
      nativeMessagingHosts = [pkgs.pywalfox-native];
      policies = {
        InstallAddonsPermission = {
          Default = true;
        };
        inherit ((import ./extensions.nix)) ExtensionSettings;
      };
      profiles = {
        "riu" = {
          id = 0;
          isDefault = true;
          settings = parseUserJS userJSContent;
          #userChrome =
          userContent = ''
            @import url("${config.home.homeDirectory}/.config/matugen/websites/colors.css");
            @import url("${config.home.homeDirectory}/.config/matugen/websites/youtube.css");
            @import url("${config.home.homeDirectory}/.config/matugen/websites/bitwarden.css");
            @import url("${config.home.homeDirectory}/.config/matugen/websites/github.css");
          '';
          search = import ./search.nix {inherit config pkgs lib;};
          bookmarks = import ./bookmarks.nix;
        };
      };
    };
  };
}
