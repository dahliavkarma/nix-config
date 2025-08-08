{
  inputs,
  hosts,
  ...
}: 
let
  # scheme = "${inputs.vity-base24}/vity.yaml";
  username = "user";
  system = "x86_64-linux";
in {
  nixosConfigurations = builtins.mapAttrs (
    hostname: hostAttrs: (
      inputs.nixpkgs.lib.nixosSystem {
        system = system;
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
          inherit system;
          inherit (hostAttrs) stateVersion;
        };
      }
    )
  ) hosts;
}