{
  config,
  pkgs,
  ...
}:
{
  # camera is now on by default, thx wj

  # auto-rorate
  hardware.sensor.iio.enable = true;

  # battery
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      const regex = /^(\/usr\/bin\/sh -c )echo \b(100|[0-9]|[1-9][0-9])\b > \/sys\/class\/power_supply\/BAT[0-1]\/(charge_control_end_threshold|charge_control_start_threshold|charge_start_threshold|charge_stop_threshold)( && echo \b(100|[0-9]|[1-9][0-9])\b > \/sys\/class\/power_supply\/BAT[0-1]\/(charge_control_end_threshold|charge_control_start_threshold|charge_start_threshold|charge_stop_threshold))?$/;
      if (action.id == "org.freedesktop.policykit.exec" && action.lookup("command_line").search(regex) !== -1) {
          return polkit.Result.YES;
      }
    });
  ''; # for capping battery (thinkpad-battery-threshold)

  # cpu
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  # fingerprint
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # touchpad
  services.libinput.touchpad = {
    tapping = true;
    tappingButtonMap = "lrm";
    disableWhileTyping = true;
  };
  # services.touchegg.enable = true; # multi-touch gesture recognizer, not compatible with Wayland

  hardware.bluetooth.enable = true;
}
