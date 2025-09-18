{
  username,
  pkgs,
  ...
}:
{

  ### Audio Extra
  security.rtkit.enable = true; # Enables rtkit (https://directory.fsf.org/wiki/RealtimeKit)

  #
  # domain = "@audio": This specifies that the limits apply to users in the @audio group.
  # item = "memlock": Controls the amount of memory that can be locked into RAM.
  # value (`unlimited`) allows members of the @audio group to lock as much memory as needed. This is crucial for audio processing to avoid swapping and ensure low latency.
  #
  # item = "rtprio": Controls the real-time priority that can be assigned to processes.
  # value (`99`) is the highest real-time priority level. This setting allows audio applications to run with real-time scheduling, reducing latency and ensuring smoother performance.
  #
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
  ];

  # Add user to `audio` and `rtkit` groups.
  users.users.${username}.extraGroups = [
    "audio"
    "rtkit"
  ];

  environment.systemPackages = with pkgs; [
    qjackctl
    rtaudio
    guitarix
  ];

  environment.sessionVariables = {
    JACK_32_BIT = [ "${pkgs.pkgsi686Linux.pipewire.jack}/lib" ];
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = 1;
    __GL_SHADER_DISK_CACHE = 1;
    __GL_SHADER_DISK_CACHE_SIZE = 100000000000;
  };

  # programs.steam.enable = true;
  # environment.systemPackages = with pkgs; [
  #   heroic
  # ];

}
