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

    consoleBg = "090200";
    consoleFg = "a4a1a1";
    consoleCursor = "a4a1a1";
    selectionBg = "494542";
    selectionFg = "090200";
    vt0 = "090200"; # black
    vt1 = "da2c20"; # red
    vt2 = "00a152"; # green
    vt3 = "fcec02"; # yellow
    vt4 = "00a0e4"; # blue
    vt5 = "a06994"; # magenta
    vt6 = "b5e4f4"; # cyan
    vt7 = "a4a1a1"; # white
    vt8 = "5b5754"; # bright black
    vt9 = "e8bacf"; # bright red
    vt10 = "3a3332"; # bright green
    vt11 = "494542"; # bright yellow
    vt12 = "7f7c7b"; # bright blue
    vt13 = "d6d4d3"; # bright magenta
    vt14 = "ccab53"; # bright cyan
    vt15 = "f7f7f7"; # bright white

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
