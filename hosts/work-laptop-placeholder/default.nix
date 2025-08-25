{
  ...
}:
{
  imports = [
    ../../common/m-system-darwinComp.nix
    ./m-looks.nix
    ./m-shell.nix
    ./m-work.nix
  ];

  homebrew = {
    enable = true;
    brews = [
      "mpv"
    ];
    casks = [
      "copyq"
      "localsend"
      "siyuan"
      "zen"
    ];
  };

  security.pam.services.sudo_local_touchIdAuth = true;
}
