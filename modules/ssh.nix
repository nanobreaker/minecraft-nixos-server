{ pkgs, ... }: {

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  # TODO Add authorization keys
  users.users.nixos.openssh.authorizedKeys.keys = [ ];
  users.users.root.openssh.authorizedKeys.keys = [ ];
}
