# noctalia-greeter

[noctalia-greeter](https://github.com/noctalia-dev/noctalia-greeter) with small
patches staged for upstream PRs. Not a source fork — `overrideAttrs` over the
upstream flake package.

**Source PR branches** live in [luxus/noctalia-greeter-1](https://github.com/luxus/noctalia-greeter-1)
(GitHub fork of upstream; this repo name is the Nix wrapper).

## Use from your flake

```nix
{
  inputs.noctalia-greeter.url = "github:luxus/noctalia-greeter";
  inputs.noctalia-greeter.inputs.nixpkgs.follows = "nixpkgs";

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
| `noctalia-greeter-output-mode.patch` | `[output] width` / `height` in `greeter.toml` | PR [#55](https://github.com/noctalia-dev/noctalia-greeter/pull/55) |
| `noctalia-greeter-idle-blank.patch` | `[idle] timeout` — blank outputs after no input | draft [#56](https://github.com/noctalia-dev/noctalia-greeter/pull/56) (after #55) |

Drop patches here once they land upstream.

## What this repo is not

- Host greeter layout (`greeter.toml` content) — [luxusAi](https://github.com/luxus/luxusAi) (`lib/noctalia-greeter-conf.nix`, `lib/lea-display-layout.nix`).
- A source tree fork — patches only, applied at build time.