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
    consoleFg = "f2f4f8";
    consoleCursor = "f2f4f8";
    selectionBg = "525252";
    selectionFg = "000000";
    vt0 = "262626"; # black
    vt1 = "ff7eb6"; # red
    vt2 = "42be65"; # green
    vt3 = "82cfff"; # yellow
    vt4 = "be95ff"; # blue
    vt5 = "ee5396"; # magenta
    vt6 = "33b1ff"; # cyan
    vt7 = "f2f4f8"; # white
    vt8 = "525252"; # bright black
    vt9 = "ff7eb6"; # bright red
    vt10 = "42be65"; # bright green
    vt11 = "82cfff"; # bright yellow
    vt12 = "be95ff"; # bright blue
    vt13 = "ee5396"; # bright magenta
    vt14 = "33b1ff"; # bright cyan
    vt15 = "ffffff"; # bright white

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
