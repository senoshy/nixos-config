{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  homeDir = path: "${config.home.homeDirectory}/${path}";
  mtgRelPath = ".config/matugen/templates";
  mtgAbsPath = homeDir mtgRelPath;
  matugenAbsPath = mtgAbsPath;
  cfg = config.home.matugen;
in {
  imports = [
    ./templates/kitty-colors.nix
    ./templates/pywalfox-colors.nix
    ./templates/midnight-discord.nix
    ./templates/Matugen.nix
    ./templates/gtk3.nix
    ./templates/gtk4.nix
    ./templates/quickshell.nix
    ./templates/qt.nix
    ./templates/nvim.nix
    ./templates/kvantum.nix
    ./templates/firefox-colors.nix
  ];

  options.home.matugen = {
    enable = lib.mkEnableOption "enable matugen module";
  };

  config = lib.mkIf cfg.enable {
    _module.args = {matugenAbsPath = mtgAbsPath;};
    xdg.userDirs = {
      createDirectories = true;
      extraConfig = {
        XDG_MATUGEN_TEMPLATES = mtgAbsPath;
      };
    };

    home.packages = with pkgs; [
      (inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default)
    ];

    home.file = {
      "${matugenAbsPath}/hyprland-colors.lua".source = ./templates/hyprland-colors.lua;
      "${matugenAbsPath}/waybar-colors.css".source = ./templates/waybar-colors.css;
      "${matugenAbsPath}/zathurarc".source = ./templates/zathurarc;
      "${config.home.homeDirectory}/.local/share/color-schemes/.keep".text = "";
    };

    home.file."${matugenAbsPath}/kvantum-colors.svg".source = ./templates/kvantum-colors.svg;

    home.file."${config.home.homeDirectory}/.config/matugen/websites/youtube.css".source = ./templates/websites/youtube.css;
    home.file."${config.home.homeDirectory}/.config/matugen/websites/bitwarden.css".source = ./templates/websites/bitwarden.css;
    home.file."${config.home.homeDirectory}/.config/matugen/websites/github.css".source = ./templates/websites/github.css;

    home.file."${config.home.homeDirectory}/.config/matugen/config.toml".text = ''
      [config]
      version_check = false

      [config.wallpaper]
      command = "awww img --transition-type center {{ image }}"

      [templates.hyprland]
      input_path = '~/.config/matugen/templates/hyprland-colors.lua'
      output_path = '~/.config/hypr/colors.lua'
      post_hook = 'hyprctl reload'

      [templates.kitty]
      input_path = '~/.config/matugen/templates/kitty-colors.conf'
      output_path = '~/.config/kitty/theme/Matugen.conf'
      post_hook = 'pkill -SIGUSR1 kitty || true'

      [templates.vencord]
      input_path = "~/.config/matugen/templates/midnight-discord.css"
      output_path = "~/.config/Vencord/themes/midnight-discord.css"

      [templates.vesktop]
      input_path = "~/.config/matugen/templates/midnight-discord.css"
      output_path = "~/.config/vesktop/themes/midnight-discord.css"

      [templates.gtk3]
      input_path = '~/.config/matugen/templates/gtk3.css'
      output_path = '~/.config/gtk-3.0/colors.css'

      [templates.gtk4]
      input_path = '~/.config/matugen/templates/gtk4.css'
      output_path = '~/.config/gtk-4.0/colors.css'

      [templates.pywalfox]
      input_path = '~/.config/matugen/templates/pywalfox-colors.json'
      output_path = '~/.cache/wal/colors.json'
      post_hook = 'pywalfox update'

      [templates.quickshell]
      input_path = '~/.config/matugen/templates/quickshell.json'
      output_path = '~/.local/state/quickshell/generated/colors.json'

      [templates.qt5ct]
      input_path = '~/.config/matugen/templates/qt.conf'
      output_path = '~/.config/qt5ct/colors/matugen.conf'

      [templates.qt6ct]
      input_path = '~/.config/matugen/templates/qt.conf'
      output_path = '~/.config/qt6ct/colors/matugen.conf'

      [templates.zathura]
      input_path = '~/.config/matugen/templates/zathurarc'
      output_path = '~/.config/zathura/zathurarc-matugen'

      [templates.nvim]
      input_path = '~/.config/matugen/templates/nvim.lua'
      output_path = '~/.config/nvim/colors/matugen.lua'
      post_hook = 'pkill -SIGUSR1 nvim'

      [templates.waybar]
      input_path = '~/.config/matugen/templates/waybar-colors.css'
      output_path = '~/.config/waybar/colors.css'
      post_hook = 'pkill -SIGUSR2 waybar'

      [templates.kde]
      input_path = '~/.config/matugen/templates/Matugen.colors'
      output_path = '~/.local/share/color-schemes/Matugen.colors'
      post_hook = 'systemctl --user try-restart plasma-xdg-desktop-portal-kde'

      [templates.kvantum_kvconfig]
      input_path = '~/.config/matugen/templates/kvantum-colors.kvconfig'
      output_path = '~/.config/Kvantum/matugen/matugen.kvconfig'

      [templates.kvantum_svg]
      input_path = '~/.config/matugen/templates/kvantum-colors.svg'
      output_path = '~/.config/Kvantum/matugen/matugen.svg'

      [templates.firefox-website-colors]
      input_path = '~/.config/matugen/templates/firefox-colors.css'
      output_path = '~/.config/matugen/websites/colors.css'

    '';
  };
}
