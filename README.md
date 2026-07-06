# noctalia-greeter

[noctalia-greeter](https://github.com/noctalia-dev/noctalia-greeter) with small
patches staged for upstream PRs. Not a source fork — `overrideAttrs` over the
upstream flake package.

## Use from your flake

```nix
{
  inputs.noctalia-greeter.url = "github:luxus/noctalia-greeter";
  inputs.noctalia-greeter.inputs.nixpkgs.follows = "nixpkgs";

  # Patched greeter + greetd nixos module (default package is already patched):
  imports = [ inputs.noctalia-greeter.nixosModules.default ];
  programs.noctalia-greeter.enable = true;
}
```

## Build

```sh
nix build .#noctalia-greeter
```

## Patches

| Patch | Purpose | Upstream |
| --- | --- | --- |
| `noctalia-greeter-output-mode.patch` | `[output] width` / `height` in `greeter.toml` to pick a DRM mode and avoid login modeset flash | Refs [noctalia-dev/noctalia-greeter#53](https://github.com/noctalia-dev/noctalia-greeter/issues/53) |

On an upstream version bump, rebuild and fix any rejected hunks. Drop patches here
once they land upstream.

## Planned

- Compositor idle screen blanking (`[idle] timeout` in `greeter.toml`) — replaces
  external logind + `wlr-randr` workarounds that cannot work on this compositor.

## What this repo is not

- **Not** host greeter layout (`greeter.toml` content, connector names, greetd PAM) —
  that stays in [luxusAi](https://github.com/luxus/luxusAi) (`lib/noctalia-greeter-conf.nix`, `lib/lea-display-layout.nix`).
- **Not** a fork of noctalia-greeter source — patches only, applied at build time.