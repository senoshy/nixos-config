{lib}: let
  colors = rec {
    base00 = "d4d0c8"; # button face / chrome / taskbar
    base01 = "ffffff"; # raised surface: windows, menus, inputs
    base02 = "000080"; # selection, highlight (classic navy)
    base03 = "808080"; # hairlines, 3D shadows, comments
    base04 = "5f5f5f"; # placeholders, line numbers
    base05 = "1a1a1a"; # body text
    base06 = "000000"; # bright text / main foreground
    base07 = "0a246a"; # hover, brightest accent (active title navy)
    base08 = "c00000"; # strongest signal, errors
    base09 = "808000"; # numbers (olive)
    base0A = "000080"; # types (navy)
    base0B = "008000"; # strings (green)
    base0C = "008080"; # escapes (teal)
    base0D = "0000a0"; # functions (blue)
    base0E = "0a246a"; # primary accent (active title navy)
    base0F = "808080"; # deprecated

    sunken = "ffffff"; # sunken surfaces / text on accent bars
    panel = "d4d0c8"; # leftover panel surface
    surfaceLow = "e4e1da";
    hover = "f0efe8"; # classic mouseover (a touch brighter than the face)
    surfaceHigh = "c0bdb6";
    active = "000080"; # pressed / active row
    surfaceVariant = "c0bdb6";
    surfaceHighest = "d9d6cf";
    outlineVariant = "a0a0a0";
    inverseOnSurface = "ffffff";
    secondaryContainer = "e0ded7";
    primaryContainer = "b0c4de";
    onPrimaryFixed = "ffffff";
    onSecondaryFixed = "000000";
    onSecondaryFixedVariant = "4a4a4a";
    onPrimary = "ffffff"; # text drawn on the navy title bar
    onSecondary = "000000";
    onSecondaryContainer = "000000";
    onError = "ffffff";
    onErrorContainer = "000000";
    error = "c00000";
    errorContainer = "ffc7c7";
    tertiaryContainer = "dbe6f5";
    black = "000000";

    consoleBg = "000000";
    consoleFg = "c0c0c0";
    consoleCursor = "ffffff";
    vt0 = "000000"; # black
    vt1 = "0000aa"; # navy
    vt2 = "00aa00"; # green
    vt3 = "00aaaa"; # teal
    vt4 = "aa0000"; # maroon
    vt5 = "aa00aa"; # purple
    vt6 = "aa5500"; # olive
    vt7 = "aaaaaa"; # silver
    vt8 = "555555"; # gray
    vt9 = "5555ff"; # blue
    vt10 = "55ff55"; # lime
    vt11 = "55ffff"; # aqua
    vt12 = "ff5555"; # red
    vt13 = "ff55ff"; # fuchsia
    vt14 = "ffff55"; # yellow
    vt15 = "ffffff"; # white

    base = base00;
    raised = base01;
    text = base06;
    dim = base05;
    primary = base0E;
    border = base03;
    critical = base08;
    highlight = base07;
  };

  names = builtins.attrNames colors;
in {
  inherit colors;

  substitute = text:
    lib.replaceStrings
    (map (name: "@${name}@") names)
    (map (name: colors.${name}) names)
    text;

  cssDefines = lib.concatMapStrings (name: "@define-color ${name} #${colors.${name}};\n") names;
}
