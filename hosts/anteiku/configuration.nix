{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
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

  hardware.logitech.wireless.enable = true;

  programs.xfconf.enable = true;
  programs.dconf.enable = true;

  boot.kernelParams = ["i915.enable_psr=0"];

  networking.hostName = "anteiku";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Cuiaba";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us-intl";
  programs.nix-ld.enable = true;

  security.pam.services.login.gnupg.enable = true;

  sops.secrets.password_senoshy = {
    key = "senoshy_password";
    neededForUsers = true;
  };

  sops.secrets.ssh_private_key = {
    owner = config.users.users.senoshy.name;
  };

  sops.secrets.senoshy_gpg = {
    owner = config.users.users.senoshy.name;
    mode = "0600";
  };

  users.users.senoshy = {
    hashedPasswordFile = config.sops.secrets.password_senoshy.path;
    home = "/home/senoshy";
    isNormalUser = true;
    description = "senoshy";
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
    inputs.spotifast.packages."${pkgs.stdenv.hostPlatform.system}".default
    config.boot.kernelPackages.cpupower
    emacs
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      intel-compute-runtime-legacy1
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  hardware.enableRedistributableFirmware = true;

  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    upower.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
  '';

  systemd.services.power-profile-performance = {
    description = "Set power profile to performance";
    wantedBy = ["multi-user.target"];
    after = ["power-profiles-daemon.service"];
    requires = ["power-profiles-daemon.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 25;
    algorithm = "zstd";
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.page-cluster" = 0;
  };

  system.stateVersion = "26.05";
}
