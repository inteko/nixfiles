{ lib, ... }:

{
  # caps toggle
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:caps_toggle";
  };

  # gnome settings
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/input-sources" = {
          sources = with lib.gvariant; [
            (mkTuple [
              "xkb"
              "us"
            ])
            (mkTuple [
              "xkb"
              "ru"
            ])
          ];
          xkb-options = [ "grp:caps_toggle" ];
        };
      };
    }
  ];
}
