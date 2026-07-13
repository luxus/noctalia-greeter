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
| `noctalia-greeter-idle-blank.patch` | `[idle] timeout` — blank outputs after no input | PR [#56](https://github.com/noctalia-dev/noctalia-greeter/pull/56) |
| `noctalia-greeter-output-transform.patch` | `[output] transforms` — portrait / rotated monitors | PR [#62](https://github.com/noctalia-dev/noctalia-greeter/pull/62) |

Drop patches here once they land upstream.

### Local test: portrait transform

1. List connectors (from a Wayland session):

```sh
noctalia-greeter outputs
```

2. In `/var/lib/noctalia-greeter/greeter.toml` (or Nix `programs.noctalia-greeter.settings`):

```toml
[output]
# optional: show greeter only on the vertical panel
# name = "HDMI-A-1"
transforms = "HDMI-A-1:90"
```

3. Disable autologin so you actually see the greeter, rebuild, then:

```sh
sudo systemctl restart greetd
```

Supported tokens: `normal`/`0`, `90`, `180`, `270`, `flipped`, `flipped-90`, …

## What this repo is not

- Host greeter layout (`greeter.toml` content) — [luxusAi](https://github.com/luxus/luxusAi) (`lib/noctalia-greeter-conf.nix`, `lib/lea-display-layout.nix`).
- A source tree fork — patches only, applied at build time.
