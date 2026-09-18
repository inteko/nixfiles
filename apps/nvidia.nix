{ ... }:

# - i configured it for my rtx3070, so u can change anything if u need

{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;

    powerManagement.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
