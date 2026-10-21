{self, ...}: {
  imports = [
    self.modules.system.audio
    self.modules.system.bluetooth
    self.modules.system.boot
    self.modules.system.browsers
    self.modules.system.fileSystem
    self.modules.system.fonts
    self.modules.system.gaming
    self.modules.system.shell
    self.modules.system.virtualisation
    self.modules.system.nix
    self.modules.system.secrets
    self.modules.system.sysdep
  ];

  system.interface.enable = true;
  system.audio.enable = true;
  system.bluetooth.enable = true;
  system.boot.enable = true;
  system.browsers.chromium.enable = true;
  system.fileSystem.enable = true;
  system.fonts.enable = true;
  system.gaming.enable = true;
  system.shell.enable = true;
  system.virtualisation.enable = true;
  system.secrets.enable = true;
  system.sysdep.enable = true;
}
