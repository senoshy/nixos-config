{pkgs, ...}: {
  force = true;
  default = "ddg";
  privateDefault = "ddg";
  engines = {
    bing.metaData.hidden = true;
    nix-packages = {
      name = "Nix Packages";
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@np"];
    };
    nix-options = {
      name = "Nix Options";
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "type";
              value = "options";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@no"];
    };
    nixos-wiki = {
      name = "NixOS Wiki";
      urls = [
        {
          template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
        }
      ];
      iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
      definedAliases = ["@nw"];
    };
    google = {
      name = "Google";
      urls = [
        {
          template = "https://www.google.com/search?q={searchTerms}";
        }
      ];
      iconMapObj."16" = "https://www.google.com/favicon.ico";
      definedAliases = ["@google"];
    };
    home-manager-options = {
      name = "Home-manager options";
      urls = [
        {
          template = "https://home-manager-options.extranix.com/";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://home-manager-options.extranix.com/favicon.ico";
      definedAliases = ["@hm"];
    };
  };
}
