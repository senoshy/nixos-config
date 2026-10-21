{
  ExtensionSettings = let
    extension = shortId: uuid: {
      name = uuid;
      value = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortId}/latest.xpi";
        installation_mode = "force_installed";
      };
    };
  in
    builtins.listToAttrs [
      (extension "ublock-origin" "uBlock0@raymondhill.net")
      #(extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
      (extension "material-icons-for-github" "{eac6e624-97fa-4f28-9d24-c06c9b8aa713}")
    ];
}
