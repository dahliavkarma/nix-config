{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    openutau
    zoom-us
  ];
}
