{
  inputs,
  username,
  pkgs,
  ...
}:
{

  # system utilities, mostly tools for the shell
  boot.kernel.sysctl."kernel.sysrq" = 1;
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  environment.enableAllTerminfo = true; # for ssh usage
  environment.systemPackages = with pkgs; [
    exfat
    inxi
    pciutils # lspci
    psmisc # fuser, killall, pstree
    usbutils # lsusb
  ];
  programs.zsh = {
    # options mildly different from nix-darwin
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    setOptions = [
      "EXTENDED_HISTORY"
      "RM_STAR_SILENT"
    ];
  };
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ]; # to get completion for system packages (e.g. systemd).
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  programs.starship.enable = true;
  environment.sessionVariables.FLAKE = "/home/${username}/nix-config";
  environment.sessionVariables.NH_FLAKE = "/home/${username}/nix-config";
  environment.variables.EDITOR = "nvim";

  # auto system tasks
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 1d";
    };
  };
  # system = {
  #   autoUpgrade = {
  #     enable = true;
  #     flake = inputs.self.outPath;
  #     flags = [
  #       "--update-input"
  #       "nixpkgs"
  #       "-L" # print build logs
  #     ];
  #     dates = "20:00";
  #     randomizedDelaySec = "45min";
  # };
  # };

  # static settings
  hardware.enableAllFirmware = true; # enable needed firmware regardless of license

}
