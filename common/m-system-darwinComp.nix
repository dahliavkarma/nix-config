{
  pkgs,
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
}
