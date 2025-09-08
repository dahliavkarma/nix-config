# About this flake

- Hosts defined in flake.nix; actual output entries are generated from hosts/default.nix, where home manager is also imported (options are defined later).
- Instead of users defined as a list, which I thought about, I just defined "username" as a string. If someone wants to share a computer with me, they can pry it from my cold dead hands.
  - Yes, "username" is visibly longer than "user". No, I don't care.
- Server (hosts/homelab) runs caddy-tailscale + Nextcloud AIO (w/ docker) + immich.
  - (Getting caddy-tailscale running on NixOS)[https://drafts.msfjarvis.dev/posts/creating-private-services-on-nixos-using-tailscale-and-caddy/]
  - (Getting Nextcloud AIO running on NixOS with caddy)[https://homeserver.guide/doing-cool-stuff/setting-up-nextcloud-on-nixos-with-https-tailscale-and-backups/]
  - The rest is trivial. 

# Todo

- [ ] set up hyprsunset before I go blind
- [X] set up yubikey
  - [X] for luks
  - [X] for login
- [X] change passwords
  - [X] set the luks passwords
  - [X] set the user passwords
- [ ] case-insensitive autocomplete with zsh
- [ ] fix the hardware temperature monitor on waybar (idk i'm lazy)
- [X] set up the homelab
  - [X] sops-nix
    - [X] set up neovim. Idk how I'm putting up with VSCode and my Vim motions are getting rusty tbh
- [X] theme the thing
  - [X] fonts
  - [X] stylix
- [X] set up fingerprint
  ~~set up flatpak~~ actually you know what I probably don't need that
- [X] add alias for emptying trash

# Notes to yourself

- When things don't build on darwin, try switching to nixpkgs-unstable. 
- Links in this readme all have snapshots on archive.org. 