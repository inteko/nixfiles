{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish.shellInit = "set -g fish_greeting"; # - disable fish shell greeting

  # - cli shortcuts are now here

  programs.fish.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/user/nixfiles#nixos";
    editcfg = "nano /home/user/nixfiles/configuration.nix";
    editflake = "nano /home/user/nixfiles/flake.nix";
    update = "cd /home/user/nixfiles && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
    check = "sudo nixos-rebuild dry-build --flake /home/user/nixfiles#nixos";
    nixclear = "sudo nix-collect-garbage -d";
  };

  users.users."user".shell = pkgs.fish;
}
