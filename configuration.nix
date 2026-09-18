{
  pkgs,
  inputs,
  ...
}:

let
  # - pinned opencode version from flake
  opencodePkgs = import inputs.nixpkgs-opencode {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  # - import every module from /apps directory
  appModules = map (name: ./apps/${name}) (builtins.attrNames (builtins.readDir ./apps));
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
  ]
  ++ appModules;

  # - boot process

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  # - nix settings

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # - system

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.enableIPv6 = false;

  time.timeZone = "Europe/Samara";
  system.stateVersion = "26.05";

  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # - desktop

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    printing.enable = true;
  };

  # Make GNOME extension GObject Introspection typelibs discoverable.
  environment.sessionVariables.GI_TYPELIB_PATH = pkgs.lib.makeSearchPath "lib/girepository-1.0" [
    pkgs.gnome-menus
    pkgs.libgtop
  ];

  # - audio

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # - user

  users.users."user" = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # - apps

  environment.systemPackages = with pkgs; [
    # - browser and socials
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ayugram-desktop
    discord

    # - opsec mr robot larp
    bitwarden-desktop
    mullvad-vpn

    # - dev
    ghostty
    opencodePkgs.opencode # - pinned from flake
    vscodium
    zed-editor
    nil
    nixd
    git
    github-cli
    wget
    fastfetch
    fish

    # - gnome
    gnome-browser-connector
    gnome-menus
  ];

  # - cli shortcuts

  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/user/nixfiles#nixos";
    editcfg = "nano /home/user/nixfiles/configuration.nix";
    editflake = "nano /home/user/nixfiles/flake.nix";
    update = "cd /home/user/nixfiles && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
    check = "sudo nixos-rebuild dry-build --flake /home/user/nixfiles#nixos";
    nixclear = "sudo nix-collect-garbage -d";
  };

}
