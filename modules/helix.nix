{ pkgs, ... }: {
  environment = { shellAliases.x = "hx"; };

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nil
    clang_16
    clang-tools_16
    helix
  ];

  # programs.helix = {
  #   enable = true;
  #   defaultEditor = true;

  #   settings = {
  #     theme = "github_dark_high_contrast";
  #     editor = {
  #       auto-format = true;
  #       auto-completion = true;
  #       bufferline = "never";
  #       color-modes = false;
  #       cursorline = true;
  #       file-picker.hidden = false;
  #       idle-timeout = 0;
  #       line-number = "relative";
  #       text-width = 140;

  #       cursor-shape = {
  #         insert = "bar";
  #         normal = "block";
  #         select = "underline";
  #       };

  #       statusline.mode = {
  #         insert = "INSERT";
  #         normal = "NORMAL";
  #         select = "SELECT";
  #       };

  #       indent-guides = {
  #         character = "▏";
  #         render = false;
  #       };

  #       whitespace.render = {
  #         tab = "all";
  #         space = "all";
  #       };

  #       whitespace.characters = {
  #         tab = "·";
  #         space = "·";
  #       };
  #     };

  #     keys.normal = {
  #       C-c = ":clipboard-yank";
  #       C-v = ":clipboard-paste-after";
  #       "C-/" = "toggle_comments";
  #     };
  #   };

  #   languages = {
  #     language = [{
  #       name = "nix";
  #       auto-format = true;
  #       formatter.command = "nixfmt";
  #       language-servers = [ "nil" ];
  #     }];
  #   };
  # };
}
