{
  description = "A very basic flake";

  inputs = {

    # basics
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
    xremap-flake.url = "github:xremap/nix-flake";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs:
    let
      hosts = {
        # don't forget ssh and ssh-agent settings for each machine
        laptop = {
          system = "x86_64-linux";
          stateVersion = "24.11"; # DO NOT ALTER!
        };
        home-desktop = {
          system = "x86_64-linux";
          stateVersion = "24.11"; # DO NOT ALTER!
        };
        homelab = {
          system = "x86_64-linux";
          stateVersion = "24.11"; # DO NOT ALTER!
        };
        work-laptop = {
          system = "aarch64-darwin";
          stateVersion = 6; # DO NOT ALTER!
        };
      };
    in
    import ./hosts {
      inherit inputs;
      inherit hosts;
    };
}
