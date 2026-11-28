{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.xremap-flake.nixosModules.default
    ./m-ime.nix
    ./m-io.nix # printer, scanner, xserver, keyboard
    ./m-kde.nix
    ./m-looks.nix
    ./m-remap.nix
    ./m-yubikey.nix # touch notifications
    # ./m-work.nix
  ];
  programs.localsend.enable = true; # firewall is opened automatically
  environment.systemPackages = with pkgs; [
    #   bitwarden # Don't even bother.
    yubioath-flutter
    yubikey-manager
  ];
}
