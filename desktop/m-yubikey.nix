{
  pkgs,
  ...
}:
{

  # notify when the yubikey waits for a touch (sudo, ssh, webauthn)
  programs.yubikey-touch-detector.enable = true;
  systemd.user.services.yubikey-touch-sound = {
    description = "Play a bell when the YubiKey waits for a touch";
    requires = [ "yubikey-touch-detector.socket" ];
    after = [ "yubikey-touch-detector.socket" ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    path = with pkgs; [
      pipewire
      socat
    ];
    script = ''
      socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/yubikey-touch-detector.socket" - |
        while IFS= read -r -n 5 event; do
          case "$event" in
            *_1) pw-play ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/bell.oga & ;;
          esac
        done
    '';
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
    };
  };

  # "Please touch the device." in the terminal for pam_u2f (sudo, login)
  security.pam.u2f.settings.cue = true;

}
