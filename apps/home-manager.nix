{ inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users."user" = {
      home.stateVersion = "26.05";

      stylix.targets = {
        gtk.enable = true;
        gnome.enable = true;
      };

      dconf.settings."org/gnome/desktop/background" = {
        picture-uri = "file://${../wallpaper/wall.png}";
        picture-uri-dark = "file://${../wallpaper/wall.png}";
        picture-options = "zoom";
      };
    };
  };
}
