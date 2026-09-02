{
  config,
  pkgs,
  lib,
  ...
}: {
  options.home.media = {
    enable = lib.mkEnableOption "enable some media (media player, social media, etc)";
    # Copia o spotify do store (imutável) para um local gravável
    # (~/.local/share/spotify) para que o spicetify consiga aplicar o tema em
    # runtime (sem precisar reconstruir via Nix a cada troca de wallpaper).
    spotifyCopyPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.local/share/spotify";
      description = "Writable copy of Spotify used by spicetify at runtime.";
    };
  };

  config = lib.mkIf config.home.media.enable {
    # spotify + spicetify-cli como pacotes normais (runtime, não store-baked)
    home.packages = with pkgs; [
      spotify
      spicetify-cli
      qview
      zathura
      kdePackages.kservice
      krita
      element-desktop
      discord
      telegram-desktop
      vlc
      yt-dlp
      mpv
      ffmpeg
    ];

    xdg.desktopEntries."element-desktop" = {
      name = "Element";
      type = "Application";
      exec = "element-desktop --password-store=gnome-libsecret %U";
      icon = "element-desktop";
      categories = ["Network" "InstantMessaging"];
      mimeType = ["x-scheme-handler/matrix"];
      startupNotify = true;
    };

    xdg.desktopEntries."spotify" = {
      name = "Spotify";
      type = "Application";
      icon = "spotify-client";
      # executa a cópia gravável (onde o spicetify injeta o tema)
      exec = "${config.home.media.spotifyCopyPath}/share/spotify/spotify %U";
      categories = ["Audio" "Music" "Player" "AudioVideo"];
      mimeType = ["x-scheme-handler/spotify"];
      startupNotify = true;
    };

    # Copia o spotify do store para ~/.local/share/spotify (idempotente) e
    # corrige o caminho absoluto do launcher para apontar para a cópia.
    home.activation.spotifyWritableCopy = lib.hm.dag.entryAfter ["writeBoundary"] ''
      dest="${config.home.media.spotifyCopyPath}"
      src="${pkgs.spotify}"
      if [ ! -d "$dest/share/spotify" ]; then
        $DRY_RUN_CMD mkdir -p "$dest"
        $DRY_RUN_CMD cp -r "$src/." "$dest/"
        $DRY_RUN_CMD chmod -R u+w "$dest"
        # aponta o exec do launcher para o .spotify-wrapped dentro da cópia
        wrapped="$dest/share/spotify/.spotify-wrapped"
        if [ -x "$dest/share/spotify/spotify" ]; then
          $DRY_RUN_CMD sed -i "s|''${src}/share/spotify/.spotify-wrapped|$wrapped|g" \
            "$dest/share/spotify/spotify"
        fi
      fi
    '';

    # Daemon que reaplica o tema toda vez que o color.ini muda (a cada
    # troca de wallpaper em que o matugen regrava o tema).
    systemd.user.services.spicetify-watch = {
      Unit = {
        Description = "Spicetify theme watcher (re-applies matugen colors)";
        After = ["spotify-writable-copy.service"];
      };
      Service = {
        Type = "simple";
        Restart = "on-failure";
        ExecStart = "${pkgs.spicetify-cli}/bin/spicetify watch -s";
      };
      Install = {WantedBy = ["default.target"];};
    };

    home.file."${config.home.homeDirectory}/.config/menus/applications.menu".text = ''
      <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
       "http://www.freedesktop.org/standards/menu-spec/menu-1.0.dtd">
      <Menu>
        <Name>Applications</Name>
        <DefaultAppDirs/>
        <DefaultDirectoryDirs/>
        <DefaultMergeDirs/>
        <Include>
          <All/>
        </Include>
      </Menu>
    '';

    home.activation.kbuildsycoca = lib.mkAfter ''
      $DRY_RUN_CMD kbuildsycoca6 --noincremental || true
    '';
  };
}
