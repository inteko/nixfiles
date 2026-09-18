{ pkgs, ... }:

{
  # disable hardware sidetone
  systemd.services.disable-microphone-monitoring = {
    description = "Disable microphone hardware monitoring";
    wantedBy = [ "multi-user.target" ];
    after = [ "sound.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.alsa-utils}/bin/amixer -c Microphone set Mic playback off"
        "${pkgs.alsa-utils}/bin/amixer -c Microphone set Speaker playback 80%"
      ];
    };
  };

  services.pipewire.wireplumber.extraConfig."51-fifine-software-volume" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          {
            "device.name" = "alsa_card.usb-MV-SILICON_fifine_Microphone_20190808-00";
          }
        ];
        actions = {
          "update-props" = {
            "api.alsa.soft-mixer" = true;
          };
        };
      }
    ];
  };
}
