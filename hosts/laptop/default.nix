{
  ...
}:
{
  imports = [
    ../../common
    ../../desktop
    ./m-boot.nix
    # ./m-gnome.nix
    ./m-hardware.nix
    # ./m-kde.nix
  ];
  nixpkgs.overlays = [
    (final: prev: {
      # ## TEMPORARY FIX for fingerprint reader, see https://github.com/NixOS/nixpkgs/issues/390101
      libfprint-2-tod1-vfs0090 =
        (prev.libfprint-2-tod1-vfs0090.override {
          libfprint-tod = prev.libfprint-tod.overrideAttrs (old: rec {
            version = "1.90.7+git20210222+tod1";
            src = old.src.overrideAttrs {
              rev = "v${version}";
              outputHash = "0cj7iy5799pchyzqqncpkhibkq012g3bdpn18pfb19nm43svhn4j";
              outputHashAlgo = "sha256";
            };
            buildInputs = (old.buildInputs or [ ]) ++ [ final.nss ];
            mesonFlags = [
              "-Ddrivers=all"
              "-Dudev_hwdb_dir=${placeholder "out"}/lib/udev/hwdb.d"
            ];
          });
        }).overrideAttrs
          { meta.broken = false; };
    })
  ];
}
