{
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  environment.systemPackages = with pkgs; [
    heroic
    zenity
  ];

}
