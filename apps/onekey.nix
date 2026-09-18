{ lib, pkgs, ... }:

let
  version = "6.5.2";

  onekeyWallet = pkgs.appimageTools.wrapType2 rec {
    pname = "onekey-wallet";
    inherit version;
    src = pkgs.fetchurl {
      url = "https://github.com/OneKeyHQ/app-monorepo/releases/download/v${version}/OneKey-Wallet-${version}-linux-x86_64.AppImage";
      hash = "sha256-pcnTlKm06EP/rVxSmmxPjK+/2tm29J7DstdH7HWjhik=";
    };

    extraInstallCommands =
      let
        contents = pkgs.appimageTools.extract { inherit pname version src; };
      in
      ''
        install -Dm444 ${contents}/onekey-wallet.desktop $out/share/applications/onekey-wallet.desktop
        install -Dm444 ${contents}/onekey-wallet.png $out/share/icons/hicolor/512x512/apps/onekey-wallet.png
        substituteInPlace $out/share/applications/onekey-wallet.desktop \
          --replace-fail 'Exec=AppRun' 'Exec=onekey-wallet'
      '';

    meta = {
      description = "OneKey cryptocurrency wallet";
      homepage = "https://onekey.so/";
      license = lib.licenses.unfree;
      platforms = [ "x86_64-linux" ];
      mainProgram = "onekey-wallet";
      sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    };
  };
in
{
  environment.systemPackages = [ onekeyWallet ];
}
