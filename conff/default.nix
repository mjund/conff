{ config, lib, pkgs, ... }:

let
  vars = import ../../../vars.nix;
  barSize = "36";
  fontSize = "14";
  # for everforest
  # barBackground = "2b3339";
  # barForeground = "dfad81";
  # for gruvbox
  barBackground = "282828";
  barForeground = "ebdbb2";

  scripts = ./scripts;
  separator = id: position: ''
    sketchybar --add item ${id} ${position} \
      --set ${id} icon= \
      icon.padding_left=0 \
      icon.padding_right=0 \
      background.padding_left=0
      background.padding_right=0
      icon.align=center
  '';
in {
  imports = [
    <home-manager/nix-darwin>
  ];

  environment.systemPackages = with pkgs; [ ];

  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
  };

  home-manager = {
    users.${vars.user} = {
      xdg.configFile.sketchybar = {
        target = "sketchybar"; 
        source = ./sketchybar;
        recursive = true;
      };

      home.file."Library/Fonts/sketchybar-app-font.ttf" = {
        source = ./sketchybar-app-font.ttf;
      };
    };
  };
}
