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
    ./m-looks.nix
    ./m-remap.nix
    # ./m-work.nix
  ];
  programs.localsend.enable = true; # firewall is opened automatically
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  # environment.systemPackages = with pkgs; [
  #   bitwarden # Don't even try.
  # ];
}
