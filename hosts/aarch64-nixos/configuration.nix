{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/disko.nix
    ../../modules/network.nix
    ../../modules/ssh.nix
    ../../modules/ghostty.nix
    ../../modules/helix.nix
  ];

  environment.systemPackages = with pkgs; [ tree ];

  system.nixos.tags = let cfg = config.boot.loader.raspberryPi;
  in [
    "raspberry-pi-${cfg.variant}"
    cfg.bootloader
    config.boot.kernelPackages.kernel.version
  ];

  boot.tmp.useTmpfs = true;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  users.users.root.initialHashedPassword = "";

  # Don't require sudo/root to `reboot` or `poweroff`.
  security.polkit.enable = true;

  # Allow passwordless sudo from nixos user
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Automatically log in at the virtual consoles.
  services.getty.autologinUser = "nixos";

  nix.settings.trusted-users = [ "nixos" ];

  time.timeZone = "UTC";

  services.udev.extraRules = ''
    # Ignore partitions with "Required Partition" GPT partition attribute
    # On our RPis this is firmware (/boot/firmware) partition
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';

  system.stateVersion = config.system.nixos.release;
}
