{
  description = "noctalia-greeter with luxus patches (upstream PR staging)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    upstream = {
      # Local multi-wallpaper + transform testing branch (no PRs yet).
      url = "github:luxus/noctalia-greeter-1/local/per-output-wallpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, upstream }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (
        pkgs:
        let
          system = pkgs.stdenv.hostPlatform.system;
        in
        rec {
          # Branch already contains transform + multi-wallpaper; pass through.
          noctalia-greeter = upstream.packages.${system}.default;
          default = noctalia-greeter;
        }
      );

      nixosModules.default =
        { pkgs, lib, ... }:
        {
          imports = [ upstream.nixosModules.default ];
          programs.noctalia-greeter.package = lib.mkDefault self.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
