{
  config,
  lib,
  matugenAbsPath,
  ...
}: {
  config = lib.mkIf config.home.matugen.enable {
    home.file."${matugenAbsPath}/firefox-colors.css".text = ''
      :root {
      <* for name, value in colors *>
          --{{name}}: {{value.default.hex}};
      <* endfor *>

      <* for name, value in colors *>
          --{{name}}_rgb: {{value.default.red}} {{value.default.green}} {{value.default.blue}};
      <* endfor *>
      }
    '';
  };
}
