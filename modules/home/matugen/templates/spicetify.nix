{
  config,
  lib,
  matugenAbsPath,
  pkgs,
  ...
}: let
  themeDir = config.home.homeDirectory + "/.config/spicetify/Themes/matugen";
in {
  config = lib.mkIf config.home.matugen.enable {
    # user.css fica intencionalmente vazio: usamos o layout Default do Spotify
    # para que nenhuma regra customizada possa quebrar a UI. As cores vêm do
    # color.ini, gerado em runtime pelo matugen (watched via spicetify watch).
    home.file = {
      "${matugenAbsPath}/spicetify-color.ini".source = ./spicetify-color.ini;
      "${config.home.homeDirectory}/.config/spicetify/Themes/matugen/user.css".source =
        ./spicetify-user.css;
    };

    home.activation.ensureSpicetifyTheme = lib.hm.dag.entryAfter ["spotifyWritableCopy"] ''
      themeDir=${toString themeDir}
      mkdir -p "$themeDir"
      # roda o setup inicial do spicetify somente se o tema ainda não foi aplicado
      if ! grep -q "current_theme.*matugen" "$HOME/.config/spicetify/config-xpui.ini" 2>/dev/null; then
        export PATH="${pkgs.spicetify-cli}/bin:$PATH"
        spotify_path="$HOME/.local/share/spotify/share/spotify"
        if [ -d "$spotify_path" ]; then
          spicetify config spotify_path "$spotify_path" || true
          spicetify config current_theme matugen color_scheme base inject_css 1 replace_colors 1 || true
          spicetify backup apply || true
        fi
      fi
    '';
  };
}
