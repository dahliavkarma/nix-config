{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {

    defaultSopsFile = ../secrets.yaml;
    validateSopsFiles = false;

    age = {
      # generate age key from host ssh key if nonexistant
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

  };

}
