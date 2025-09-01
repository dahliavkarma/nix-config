{
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      gImageReader # from file
      gnome-frog # from clipboard
    ]
    ++ (with pkgs.hunspellDicts; [
      ru_RU
    ]);
}
