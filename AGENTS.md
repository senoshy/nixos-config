# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project overview

This repo contains my personal NixOS configuration, managed declaratively with Nix flakes. It defines one or more hosts (and optionally Home Manager configurations) that I build and deploy myself.

<!-- Edit these to match your setup -->
- **Hosts:** `anteiku`
- **Channel / inputs:** `nixpkgs unstable`
- **Architecture:** `x86_64-linux`

## Repository layout

Adjust to match reality; agents should trust the actual tree over this section.

```
.
├── flake.nix            # Entry point: inputs and outputs
├── flake.lock           # Pinned inputs (do not hand-edit)
├── statix.toml
├── .sops.yaml           # sops key recipients; do not edit
├── home/
│    └── senoshy/
│       ├── home.nix
│       └── modules.nix
├── hosts/
│   └── anteiku/
│       ├── configuration.nix
│       ├── disko.nix
│       ├── modules.nix
│       ├── modules/     # Host specific configurations/packages
│       └── hardware.nix # Generated; do not edit
├── modules/
│   ├── nixos/           # Reusable NixOS modules
│   └── home/            # Home Manager modules
├── lib/default.nix
├── overlays/
├── pkgs/                # Custom packages
└── secrets/             # Encrypted secrets only (sops-nix / agenix)
```

## Commands

Always use these to validate changes. Prefer the cheapest check that proves the change.

```bash
# Format (run before finishing any task)
nix fmt

# Evaluate everything, catch errors fast
nix flake check

# Linting
statix check .

# Build a host without activating it
nixos-rebuild build --flake .#<hostname>

# Show what would change
nixos-rebuild dry-build --flake .#<hostname>

# Diff against the current system (if nvd or nix-diff is available)
nvd diff /run/current-system ./result

# Inspect an option value
nix eval .#nixosConfigurations.<hostname>.config.<option.path>
```

## Hard rules (never do these)

- **Never run** `nixos-rebuild switch|boot|test`, `sudo`, `nix-collect-garbage`, or anything that activates or mutates the live system. Build only; I deploy myself.
- **Never edit or read** `.sops.yaml` or `secrets/secrets.yaml`, or run `sops` on them.
- **Never edit** `hardware.nix`, `disko.nix` or `flake.lock` by hand. Update inputs only when I ask, using `nix flake update <input>`.
- **Never change** `system.stateVersion` or `home.stateVersion`. These are not version bumps.
- **Never commit or print secrets**, keys, tokens, or passwords. Secrets live in the encrypted secrets directory only.
- **Never use** `--impure` or `builtins.fetchurl`/`fetchTarball` without a pinned hash, and never disable sandboxing.
- **Do not** commit, push, or rewrite git history unless I explicitly ask.
- **Do not** convert non-nix files to nix files. Only convert when I ask.
- **Do not** change vendored files like `betterfox.js`. Only change when I ask.  

## Conventions

### Nix style
- Format with the repo's formatter (`nix fmt`, e.g. `nixfmt` or `alejandra`). No manual style debates.
- Prefer `lib.mkIf`, `lib.mkDefault`, `lib.mkEnableOption`, and `lib.mkOption` with `description` and `type` over ad-hoc attributes.
- Avoid `with pkgs;` at file scope; use `pkgs.foo` or `inherit (pkgs) foo;`.
- Avoid `rec`; use `let ... in` instead.
- Do not use deprecated options. Check the current option name in the NixOS manual or via `nix eval` before assuming.
- Use `lib.getExe` for referencing binaries in services and scripts.

### Structure
- One concern per module. Put reusable logic in `modules/`, host-specific values in `hosts/<hostname>/`.
- New modules should be opt-in via an `enable` option, unless they are universally needed.
- New files must be tracked by git (`git add`) or flakes will not see them. Tell me if a build fails for this reason.
- Keep host files thin: they should mostly import modules and set host-specific values.

### Packages
- Prefer packages from `nixpkgs` over custom derivations. Add custom packages under `pkgs/` only when necessary.
- Pin fetchers with hashes (`hash = "sha256-..."`); use `lib.fakeHash` only transiently to obtain the real hash.

## Workflow for changes

1. Read the relevant modules and the host file before editing.
2. Make the smallest change that solves the task. Do not refactor unrelated code.
3. Run `nix fmt`, then `nix flake check`, then `nixos-rebuild build --flake .#<hostname>` for every host affected.
4. Summarize what changed, which hosts are affected, and anything I need to do manually (for example secrets, reboots, or `switch`).
5. If a change could affect boot, networking, disk layout, or login (bootloader, filesystems, `networking.*`, display manager, users), flag it clearly as risky.

## When uncertain

- If an option, package, or module behavior is unclear, check the source or documentation rather than guessing. State any assumption in the summary.
- If a task is ambiguous or touches the hard-rule areas above, ask before proceeding.
- If a build fails, report the actual error and what you tried; do not paper over it with workarounds like disabling checks.

## Commit style (only when asked to commit)

Short imperative subject, scoped by area, for example:
`hosts/anteiku: enable bluetooth`, `modules/nixos/gaming: add steam module`.
