{
  inputs,
  hosts,
  ...
}:
let
  # scheme = "${inputs.vity-base24}/vity.yaml";
  username = "user";

  isLinux =
    host: lib.hasPrefix "x86_64-linux" host.system || lib.hasPrefix "aarch64-linux" host.system;
  isDarwin =
    host: lib.hasPrefix "x86_64-darwin" host.system || lib.hasPrefix "aarch64-darwin" host.system;

  linuxHosts = lib.filterAttrs (_: v: isLinux v) hosts;
  darwinHosts = lib.filterAttrs (_: v: isDarwin v) hosts;

  lib = inputs.nixpkgs.lib;
in
{
  nixosConfigurations = builtins.mapAttrs (
    hostname: hostAttrs:
    (inputs.nixpkgs.lib.nixosSystem {
      system = hostAttrs.system;
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        inputs.stylix.nixosModules.stylix
        ./${hostname}
      ];
      specialArgs = {
        inherit inputs;
        inherit hostname;
        inherit username;
        inherit (hostAttrs) system;
        inherit (hostAttrs) stateVersion;
      };
    })
  ) linuxHosts;
  darwinConfigurations = builtins.mapAttrs (
    hostname: hostAttrs:
    (inputs.nix-darwin.lib.darwinSystem {
      system = hostAttrs.system;
      modules = [
        inputs.home-manager.darwinModules.home-manager
        inputs.sops-nix.darwinModules.sops
        inputs.stylix.darwinModules.stylix
        ./${hostname}
      ];
      specialArgs = {
        inherit inputs;
        inherit hostname;
        inherit username;
        inherit (hostAttrs) system;
        inherit (hostAttrs) stateVersion;
      };
    })
  ) darwinHosts;
}
