{ ... }:

{
  # - ssh from local network
  services.openssh = {
    enable = true;
    openFirewall = true;
  };
}
