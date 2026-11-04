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
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };

    programs.librewolf.enable = true;

    programs.firefox = {
      enable = lib.mkDefault true;
      package = pkgs.firefox;
      policies = {
        InstallAddonsPermission = {
          Default = true;
        };
        inherit ((import ./extensions.nix)) ExtensionSettings;
      };
      profiles = {
        "senoshy" = {
          id = 0;
          isDefault = true;
          settings = parseUserJS userJSContent;
          userChrome = ''
            :root,
            #navigator-toolbox,
            #sidebar-main,
            #sidebar-box,
            #sidebar,
            #urlbar,
            #urlbar-input,
            toolbar,
            menupopup,
            menuitem,
            .tab-text,
            tab {
              font-family: "Open Sans", sans-serif !important;
            }
          '';
          userContent = ''
          '';
          search = import ./search.nix {inherit config pkgs lib;};
          bookmarks = import ./bookmarks.nix;
        };
      };
    };
  };
}
