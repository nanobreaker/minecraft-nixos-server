{
  description = "Minecraft NixOS Server ";

  nixConfig = {
    bash-prompt = "[nixos-raspberrypi-demo] ➜ ";
    extra-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
    connect-timeout = 5;
  };

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-raspberrypi = { url = "github:nvmd/nixos-raspberrypi/main"; };

    disko = {
      url = "github:nvmd/disko/gpt-attrs";
      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };

    nixos-anywhere = { url = "github:nix-community/nixos-anywhere"; };
  };

  outputs = inputs@{ self, nixpkgs, nixos-raspberrypi, disko, ... }:
    let inherit (self) outputs;
    in {
      nixosConfigurations = {
        rpi5 = nixos-raspberrypi.lib.nixosSystemFull {
          system = "aarch64-nixos";
          specialArgs = { inherit inputs outputs nixos-raspberrypi; };
          modules = [
            nixos-raspberrypi.nixosModules.raspberry-pi-5.base
            disko.nixosModules.disko
            ./hosts/aarch64-nixos/configuration.nix

            ({ config, pkgs, lib, ... }:
              let kernelBundle = pkgs.linuxAndFirmware.v6_6_31;
              in {
                boot = {
                  loader.raspberryPi.firmwarePackage =
                    kernelBundle.raspberrypifw;
                  kernelPackages = kernelBundle.linuxPackages_rpi5;
                };

                nixpkgs.overlays = lib.mkAfter [
                  (self: super: {
                    inherit (kernelBundle) raspberrypiWirelessFirmware;
                    inherit (kernelBundle) raspberrypifw;
                  })
                ];
              })
          ];
        };
      };
    };
}
