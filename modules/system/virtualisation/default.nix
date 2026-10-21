{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.system.virtualisation;
in {
  options.system.virtualisation = {
    enable = lib.mkEnableOption "enable virtualisation module";
  };
  config = lib.mkIf cfg.enable {
    boot.kernelParams = ["kvm.ignore_msrs=1"];
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      quickemu
      quickgui
      virt-manager
      spice-gtk
      remmina
    ];
  };
}
