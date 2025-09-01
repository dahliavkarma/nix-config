{
  inputs, 
  pkgs,
  stateVersion,
  system,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    bat
    eza
    nixd
    nixfmt-rfc-style
    p7zip
    ripgrep-all
    tldr
    unzip
    vim
    wget
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = system;
  system.stateVersion = stateVersion;
}
