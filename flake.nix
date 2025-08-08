{
  description = "A very basic flake";

  inputs = {

    # basics
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

  };

  outputs = inputs: 
  let 
    hosts = { # don't forget ssh and ssh-agent settings for each machine
      laptop = {
        stateVersion = "24.11"; # DO NOT ALTER!
       };
      home-desktop = {
        stateVersion = "24.11"; # DO NOT ALTER!
      };
      homelab = {
        stateVersion = "24.11"; # DO NOT ALTER!
      };
    };
  in 
    import ./hosts {
      inherit inputs;
      inherit hosts; 
    };
}
