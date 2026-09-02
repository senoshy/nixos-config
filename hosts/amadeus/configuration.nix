{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.nix-gaming.nixosModules.platformOptimizations
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.qylock.nixosModules.default
    ./disko.nix
    ./modules.nix
    ./hardware.nix
    ./modules
  ];

  documentation = {
    enable = true;
    man.enable = true;
    doc.enable = true;
    info.enable = true;
    nixos.enable = false;
  };

  services.ratbagd.enable = true;
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  nix.settings.allow-import-from-derivation = lib.mkForce true;

  networking.hostName = "amadeus";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Cuiaba";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us-intl";

  programs.nix-ld.enable = true;

  security.pam.services.login.gnupg.enable = true;

  sops.secrets.password_riu = {
    key = "riu_password";
    neededForUsers = true;
  };

  sops.secrets.ssh_private_key = {
    owner = config.users.users.riu.name;
  };

  sops.secrets.riu_gpg = {
    owner = config.users.users.riu.name;
    mode = "0600";
  };

  users.users.riu = {
    hashedPasswordFile = config.sops.secrets.password_riu.path;
    home = "/home/riu";
    isNormalUser = true;
    description = "riu";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "docker"
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    config.boot.kernelPackages.cpupower
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime-legacy1
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  hardware.enableRedistributableFirmware = true;

  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = false;
    throttled.enable = false;
    auto-cpufreq.enable = false;
    upower.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 40;
    algorithm = "zstd";
  };

  system.stateVersion = "26.05";
}
