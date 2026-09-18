{ config, pkgs, ... }:

{
  # - theme

  stylix = {
    enable = true;
    image = ../wallpaper/wall.png;
    imageScalingMode = "fill";
    polarity = "dark";

    # The wallpaper is nearly monochrome, so use a high-contrast night palette.
    base16Scheme = {
      base00 = "0B111B";
      base01 = "111C2B";
      base02 = "1B2B40";
      base03 = "40516A";
      base04 = "71839B";
      base05 = "DBE5F0";
      base06 = "F2F6FA";
      base07 = "FFFFFF";
      base08 = "FF6B7A";
      base09 = "FFAD66";
      base0A = "F5D06F";
      base0B = "8BD5CA";
      base0C = "73DACA";
      base0D = "6EB5FF";
      base0E = "C6A7FF";
      base0F = "F2A7D8";
    };

    fonts = {
      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
  };
}
